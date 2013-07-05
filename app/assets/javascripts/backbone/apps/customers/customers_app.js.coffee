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

    newCustomerForm: (customer, customers) ->
      CustomersApp.New.Controller.newCustomer customer, customers

    editCustomer: (customer) ->
      CustomersApp.Edit.Controller.editCustomer customer

  App.addInitializer ->
    new CustomersApp.Router
      controller: API

  App.reqres.setHandler "customer:show", (customer) ->
    API.showCustomer(customer.id)

  App.reqres.setHandler "new:customer:form:view", (customer, customers) ->
    API.newCustomerForm(customer, customers)

  App.reqres.setHandler "edit:customer:form", (customer) ->
    API.editCustomer customer

  App.reqres.setHandler "add:purchase:form:view", (customerId) ->
    console.log 'catched call to purchase form for customer with id ' + customerId

  App.reqres.setHandler "add:payment:form:view", (customerId) ->
    console.log 'catched call to payment form for customer with id ' + customerId

  App.vent.on "customer:cancelled customer:updated", (customer) ->
    API.showCustomer customer.id

  App.vent.on "customer:created", (customer, customers) ->
    customers.add customer

  App.vent.on "customer:destroyed", (customer) ->
    customer.destroy()
    App.navigate( Routes.customers_path(), trigger: true )
