@Badi.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Customer extends Entities.Model
    urlRoot: ->
      Routes.api_customers_path()

    initialize: ->
      editableFields = ['name', 'email', 'phone']
      @editableFields = editableFields

  class Entities.CustomersCollection extends Backbone.Collection
    url: ->
      Routes.api_customers_path()

    model: Entities.Customer
    comparator: 'name'

  API =
    fetchCustomers: ->
      customers = new Entities.CustomersCollection
      customers.fetch
        reset: true
      customers

    fetchCustomer: (customerId, cb) ->
      customer = new Entities.Customer id: customerId
      customer.fetch
        success: ->
          cb customer

    getCustomer: (customerId) ->
      customer= new Entities.Customer id: customerId
      customer.fetch()
      customer

    newCustomer: (customers) ->
      new Entities.Customer
        collection: customers

  App.reqres.setHandler "customers:fetch", ->
    API.fetchCustomers()

  App.reqres.setHandler "customer:fetch", (customerId, cb) ->
    API.fetchCustomer(customerId, cb)

  App.reqres.setHandler "customer:get", (customerId) ->
    API.getCustomer customerId

  App.reqres.setHandler "new:customer:entity", (customers) ->
    API.newCustomer(customers)
