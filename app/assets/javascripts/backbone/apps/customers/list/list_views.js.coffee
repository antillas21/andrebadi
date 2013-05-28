@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.CustomerRow extends Marionette.ItemView
    tagName: 'tr'
    className: 'js'
    template: 'customers/templates/list/customer_row'

    events:
      "click h4" : "clickedCustomer"

    clickedCustomer: ->
      @trigger "customer:show", @model

  class List.CustomersTable extends Marionette.CompositeView
    template: 'customers/templates/list/customers_table'
    itemView: List.CustomerRow
    itemViewContainer: 'tbody'
