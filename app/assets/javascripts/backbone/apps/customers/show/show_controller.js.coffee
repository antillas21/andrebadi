@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =
    showCustomer: (customerId) ->
      App.request "customer:fetch", customerId, (customer) =>

        customer_view = new Show.CustomerFullView
                          model: customer

        App.mainRegion.show customer_view

