@Badi.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Customer extends Backbone.Model
    urlRoot: '/api/customers'
    # urlRoot: ->
    #   Routes.customers_path()

    initialize: ->
      editableFields = ['name', 'email', 'phone']
      @editableFields = editableFields

  class Entities.CustomersCollection extends Backbone.Collection
    url: '/api/customers'
    # url: ->
    #   Routes.customers_path()

    model: Entities.Customer
    comparator: 'name'

  API =
    fetchCustomers: ->
      customers = new Entities.CustomersCollection
      customers.fetch
        fetch: true
      customers

    fetchCustomer: (customerId, cb) ->
      customer = new Entities.Customer id: customerId
      customer.fetch
        success: ->
          cb customer

  App.reqres.setHandler "customers:fetch", ->
    API.fetchCustomers()

  App.reqres.setHandler "customer:fetch", (customerId, cb) ->
    API.fetchCustomer(customerId, cb)
