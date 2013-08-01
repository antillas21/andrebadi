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
      new SalesApp.Edit.Controller
        id: id

    newSale: (id, customer) ->
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
    API.newSale customerId, customer

  App.vent.on "sale:created", (sale) ->
    API.editSale sale.id

  App.vent.on "sale:updated", (sale) ->
    API.showSale sale.id
