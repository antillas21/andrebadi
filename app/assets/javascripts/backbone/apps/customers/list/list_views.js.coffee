@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.CustomerRow extends Marionette.ItemView
    tagName: 'tr'
    className: 'js'
    template: 'customers/templates/list/customer_row'

    events:
      "click" : "logCustomer"

    logCustomer: ->
      console.log @model

  class List.CustomersTable extends Marionette.CompositeView
    template: 'customers/templates/list/customers_table'
    itemView: List.CustomerRow
    itemViewContainer: 'tbody'
