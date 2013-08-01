@SaleTrackr.module "CustomersApp", (CustomersApp, App, Backbone, Marionette, $, _) ->
  class CustomersApp.Router extends Marionette.AppRouter
    appRoutes:
      "customers" : "listCustomers"
      "customers/:id" : "showCustomer"
      "customers/:id/edit" : "editCustomer"

  API =
    listCustomers: ->
      new CustomersApp.List.Controller

    showCustomer: (id) ->
      new CustomersApp.Show.Controller id

    newCustomerForm: (options = {}) ->
      new CustomersApp.New.Controller(options).customerView

    editCustomer: (options = {}) ->
      new CustomersApp.Edit.Controller(options).editCustomerView

  App.addInitializer ->
    new CustomersApp.Router
      controller: API

  App.reqres.setHandler "customer:show", (customer) ->
    API.showCustomer(customer.id)

  App.reqres.setHandler "new:customer:form:view", (customer, customers) ->
    API.newCustomerForm
      customer: customer
      customers: customers

  App.reqres.setHandler "edit:customer:form", (customer) ->
    API.editCustomer
      customer: customer

  App.vent.on "customer:cancel customer:updated payment:cancel payment:created", (customer) ->
    API.showCustomer customer.id

  App.vent.on "customer:created", (customer, customers) ->
    customers.add customer

  App.vent.on "customer:destroyed", (customer) ->
    customer.destroy()
    App.navigate( Routes.customers_path(), trigger: true )
