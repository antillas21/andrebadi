@Badi.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  New.Controller =
    newCustomer: (customer, customers) ->
      newView = @getNewView customer, customers
      newView

    getNewView: (customer, customers) ->
      new New.Form
        model: customer
        collection: customers
