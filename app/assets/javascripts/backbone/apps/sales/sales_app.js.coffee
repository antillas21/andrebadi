@SaleTrackr.module "SalesApp", (SalesApp, App, Backbone, Marionette, $, _) ->

  class SalesApp.Router extends Marionette.AppRouter
    appRoutes:
      "sales" : "listSales"
      "sales/:id" : "showSale"
      "sales/:id/edit" : "editSale"

  API =
    listSales: ->
      console.log "listing Sales"

    showSale: (id) ->
      new SalesApp.Show.Controller id

    editSale: (id) ->
      console.log "editing Sale id: ", id

  App.addInitializer ->
    new SalesApp.Router
      controller: API
