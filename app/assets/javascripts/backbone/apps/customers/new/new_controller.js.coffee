@Badi.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { customer, customers} = options
      newView = @getNewView customer, customers
      @customerView = newView

    getNewView: (customer, customers) ->
      new New.Form
        model: customer
        collection: customers
