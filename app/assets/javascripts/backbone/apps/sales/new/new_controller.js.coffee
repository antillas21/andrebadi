@SaleTrackr.module "SalesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      App.navigate( Routes.new_sale_path() )
      { customer_id } = options

      sale = App.request "new:sale:entity", customer_id
      console.log sale

      @layout = @getLayout()

      @listenTo @layout, "show", ->
        @actionsRegion sale
        @saleRegion sale

      @show @layout

    getLayout: ->
      new New.Layout

    actionsRegion: (sale) ->
      actionsView = @getActionsView sale
      console.log actionsView
      @layout.actionsRegion.show actionsView

    saleRegion: (sale) ->
      saleView = @getSaleView sale
      @layout.saleRegion.show saleView

    getSaleView: (sale) ->
      new New.Sale
        model: sale

    getActionsView: (sale) ->
      new New.Actions
        model: sale
