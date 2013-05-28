@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =
    listCustomers: ->
      console.log 'called listCustomers from the CustomersApp.List.Controller'
      customers = App.request "customers:fetch"

      customers_table = new List.CustomersTable
                          collection: customers

      customers_table.on "itemview:customer:show", (childView, model) ->
        App.request "customer:show", model


      App.mainRegion.show customers_table
