@SaleTrackr.module "SalesApp", (SalesApp, App, Backbone, Marionette, $, _) ->

  class SalesApp.Router extends Marionette.AppRouter
    appRoutes:
      "sales"           : "listSales"
      "sales/:id"       : "showSale"
      "sales/:id/edit"  : "editSale"
      "sales/new"       : 'newSale'

  API =
    listSales: ->
      new SalesApp.List.Controller

    showSale: (id) ->
      new SalesApp.Show.Controller id

    editSale: (id) ->
      console.log "editing Sale id: ", id

    newSale: (id, customer) ->
      console.log 'from SalesApp.Router via API.createSale', id, customer
      new SalesApp.New.Controller
        customer_id: id
        customer: customer

  App.addInitializer ->
    new SalesApp.Router
      controller: API

  App.vent.on "sale:destroyed", (sale) ->
    sale.destroy()
    App.navigate( Routes.sales_path(), trigger: true )

  App.vent.on "sale:new", (customerId, customer) ->
    console.log 'should create a Sale for CustomerId', customerId, customer
    API.newSale customerId, customer
