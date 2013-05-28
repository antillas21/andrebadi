@Badi.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Customer extends Backbone.Model
    urlRoot: ->
      Routes.customers_path()

  class Entities.CustomersCollection extends Backbone.Collection
    url: ->
      Routes.customers_path()

    model: Entities.Customer
    comparator: 'name'

  API =
    fetchCustomers: ->
      customers = new Entities.CustomersCollection
      customers.fetch
        fetch: true
      customers

  App.reqres.setHandler "customers:fetch", ->
    API.fetchCustomers()
