@Badi.module "CustomersApp", (CustomersApp, App, Backbone, Marionette, $, _) ->
  class CustomersApp.Router extends Marionette.AppRouter
    appRoutes:
      "customers" : "listCustomers"
      "customers/:id" : "showCustomer"

  API =
    listCustomers: ->
      CustomersApp.List.Controller.listCustomers()

    showCustomer: (id) ->
      CustomersApp.Show.Controller.showCustomer(id)

  App.addInitializer ->
    new CustomersApp.Router
      controller: API

  App.reqres.setHandler "customer:show", (customer) ->
    API.showCustomer(customer.id)
