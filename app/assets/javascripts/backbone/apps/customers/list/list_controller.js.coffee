@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =
    listCustomers: ->
      console.log 'called listCustomers from the CustomersApp.List.Controller'
      customers = App.request "customers:fetch"
      window.customers = customers

      customers_table = new List.CustomersTable
                          collection: customers

      App.mainRegion.show customers_table
