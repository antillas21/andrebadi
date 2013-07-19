@SaleTrackr.module "SalesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base
    initialize: (id) ->
      App.request "sale:fetch", id, (sale) =>

        window.sale = sale
        @layout = @getLayout sale

        @listenTo @layout, "show", ->
          @saleRegion sale
          @actionsRegion sale

        @show @layout

    saleRegion: (sale) ->
      saleView = @getSaleView sale
      @layout.saleRegion.show saleView

    actionsRegion: (sale) ->
      actionsView = @getActionsView sale
      @layout.actionsRegion.show actionsView

    getSaleView: (sale) ->
      new Show.Sale
        model: sale

    getActionsView: (sale) ->
      new Show.Actions
        model: sale

    getLayout: (sale) ->
      new Show.Layout
        model: sale