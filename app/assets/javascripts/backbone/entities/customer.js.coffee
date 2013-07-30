@SaleTrackr.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Customer extends Entities.Model
    urlRoot: ->
      Routes.api_customers_path()

  class Entities.CustomersCollection extends Backbone.QueryCollection
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

    getCustomer: (customerId) ->
      customer= new Entities.Customer id: customerId
      customer.fetch()
      customer

    fetchCustomer: (customerId) ->
      defer = $.Deferred()
      customer = new Entities.Customer
        id: customerId

      customer.fetch
        success: (data) ->
          defer.resolve data

      defer.promise()

    newCustomer: ->
      new Entities.Customer

  App.reqres.setHandler "customers:fetch", ->
    API.fetchCustomers()

  App.reqres.setHandler "customer:fetch", (customerId) ->
    API.fetchCustomer customerId

  App.reqres.setHandler "customer:get", (customerId) ->
    API.getCustomer customerId

  App.reqres.setHandler "new:customer:entity", ->
    API.newCustomer()
