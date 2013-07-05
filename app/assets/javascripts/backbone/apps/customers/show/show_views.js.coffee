@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.TransactionItem extends Marionette.ItemView
    template: 'customers/templates/show/transactions_item'
    tagName: 'tr'
    className: 'js-row'

  class Show.TransactionsList extends Marionette.CompositeView
    tagName: 'div'
    className: 'js-list'
    template: 'customers/templates/show/transactions_list'
    itemView: Show.TransactionItem
    itemViewContainer: 'tbody'

  class Show.CustomerLayout extends Marionette.Layout
    className: 'js-layout customer-layout'
    template: 'customers/templates/show/customer_layout'

    regions:
      panelRegion: "#panel-region"
      customerRegion: "#customer-region"
      transactionsRegion: "#transactions-region"

  class Show.CustomerFullView extends Marionette.ItemView
    template: 'customers/templates/show/customer_full_view'

    modelEvents:
      "sync" : "render"

  class Show.CustomerPanel extends Marionette.ItemView
    template: 'customers/templates/show/panel'

    triggers:
      "click #edit-customer" : "edit:customer:button:clicked"
      "click #add-purchase" : "add:purchase:button:clicked"
      "click #add-payment" : "add:payment:button:clicked"
      "click #delete-customer" : "delete:customer:button:clicked"
