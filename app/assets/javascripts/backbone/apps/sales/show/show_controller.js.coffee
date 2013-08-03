@SaleTrackr.module "SalesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base
    initialize: (id) ->
      App.navigate( Routes.sale_path id )
      fetchingSale = App.request 'sale:fetch', id
      $.when(fetchingSale).done (sale) =>
        @layout = @getLayout sale
        @line_items = new App.Entities.LineItems sale.attributes.line_items

        @listenTo @line_items, 'add', ->
          console.log 'we should have triggered rendering totalsView'
          App.vent.trigger 'update:sale:totals', sale

        @listenTo @layout, 'show', =>
          @saleRegion sale, @line_items
          @actionsRegion sale

        @show @layout

    saleRegion: (sale, items) ->
      @saleLayout = new Show.SaleLayout

      @listenTo @saleLayout, 'show', =>
        @renderItems items, sale
        @renderTotals sale

      @layout.saleRegion.show @saleLayout

    actionsRegion: (sale) ->
      actionsView = @getActionsView sale

      @listenTo actionsView, "sale:delete:clicked", =>
        App.vent.trigger "sale:destroyed", sale

      @listenTo actionsView, "add:item:clicked", =>
        @newItemRegion sale, @line_items

      @layout.actionsRegion.show actionsView

    renderItems: (items, sale) ->
      lineItemsView = new Show.SaleItems
        collection: items

      lineItemsView.on 'itemview:item:remove', (childview, model) =>
        @line_items.remove childview.model
        childview.model.destroy()
        App.vent.trigger 'update:sale:totals', sale

      @saleLayout.itemsRegion.show lineItemsView

    renderTotals: (sale) ->
      totalsView = new Show.SaleTotals
        model: sale

      totalsView.listenTo App.vent, 'update:sale:totals', =>
        sale.fetch()
        console.log 'catching from totalsView instance', @, sale, totalsView

      @saleLayout.totalsRegion.show totalsView


    getSaleView: (sale, items) ->
      new Show.Sale
        model: sale
        collection: items

    getActionsView: (sale) ->
      new Show.Actions
        model: sale

    getLayout: (sale) ->
      new Show.Layout
        model: sale

    newItemRegion: (sale, items) ->
      lineItem = App.request 'new:item:entity', sale.id

      newView = App.request "new:item:form:view", lineItem, @line_items
      formView = App.request "form:wrapper", newView

      @listenTo lineItem, "created", =>
        App.vent.trigger "item:created", lineItem, @line_items
        newView.close()
        @layout.newItemRegion.close()

      @listenTo newView, "form:cancel", =>
        newView.close()
        @layout.newItemRegion.close()

      @layout.newItemRegion.show formView
