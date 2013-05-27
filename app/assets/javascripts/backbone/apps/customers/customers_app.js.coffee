@Badi.module "CustomersApp", (CustomersApp, App, Backbone, Marionette, $, _) ->
  class CustomersApp.Router extends Marionette.AppRouter
    appRoutes:
      "customers" : "listCustomers"

  API =
    listCustomers: ->
      CustomersApp.List.Controller.listCustomers()

  App.addInitializer ->
    new CustomersApp.Router
      controller: API
