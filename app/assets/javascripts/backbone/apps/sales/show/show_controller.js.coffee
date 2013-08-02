@SaleTrackr.module "SalesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base
    initialize: (id) ->
      fetchingSale = App.request 'sale:fetch', id
      $.when(fetchingSale).done (sale) =>
        @layout = @getLayout sale
        @line_items = new App.Entities.LineItems sale.attributes.line_items

        @listenTo @layout, 'show', =>
          @saleRegion sale, @line_items
          @actionsRegion sale

        @show @layout

    saleRegion: (sale, items) ->
      saleView = @getSaleView sale, items
      console.log saleView

      @layout.saleRegion.show saleView

    actionsRegion: (sale) ->
      actionsView = @getActionsView sale

      @listenTo actionsView, "sale:delete:clicked", =>
        App.vent.trigger "sale:destroyed", sale

      @listenTo actionsView, "add:item:clicked", =>
        # @layout.actionsRegion.close()
        console.log "add item to sale", sale

      @layout.actionsRegion.show actionsView

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
