@SaleTrackr.module "SalesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base
    initialize: ->
      sales = App.request "sales:fetch"
      window.sales = sales

      @layout = @getLayout()

      @listenTo @layout, "show", ->
        @panelRegion sales
        @salesRegion sales

      @show @layout

    getLayout: ->
      new List.Layout

    panelRegion: (sales) ->
      panelView = @getPanelView sales
      @layout.panelRegion.show panelView

    salesRegion: (sales) ->
      salesView = @getSalesView sales
      @layout.salesRegion.show salesView

    getPanelView: (sales) ->
      new List.Panel
        collection: sales

    getSalesView: (sales) ->
      new List.Table
        collection: sales
