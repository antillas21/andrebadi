@Badi.module "CustomersApp", (CustomersApp, App, Backbone, Marionette, $, _) ->
  class CustomersApp.Router extends Marionette.AppRouter
    appRoutes:
      "customers" : "listCustomers"
      "customers/:id" : "showCustomer"
      "customers/:id/edit" : "editCustomer"

  API =
    listCustomers: ->
      CustomersApp.List.Controller.listCustomers()

    showCustomer: (id) ->
      CustomersApp.Show.Controller.showCustomer id

    newCustomerForm: ->
      CustomersApp.New.Controller.newCustomer()

    editCustomer: (id) ->
      CustomersApp.Edit.Controller.editCustomer id

  App.addInitializer ->
    new CustomersApp.Router
      controller: API

  App.reqres.setHandler "customer:show", (customer) ->
    API.showCustomer(customer.id)

  App.reqres.setHandler "new:customer:form:view", ->
    API.newCustomerForm()

  App.vent.on "edit:customer:form", (customerId) ->
    App.navigate Routes.edit_customer_path(customerId)
    API.editCustomer customerId

  App.reqres.setHandler "add:purchase:form:view", (customerId) ->
    console.log 'catched call to purchase form for customer with id ' + customerId

  App.reqres.setHandler "add:payment:form:view", (customerId) ->
    console.log 'catched call to payment form for customer with id ' + customerId
