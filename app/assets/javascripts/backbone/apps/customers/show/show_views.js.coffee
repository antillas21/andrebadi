@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.TransactionsItemView extends Marionette.ItemView
    template: 'customers/templates/show/transactions_item'
    tagName: 'tr'
    className: 'js-row'

  class Show.TransactionsListView extends Marionette.CompositeView
    tagName: 'div'
    className: 'js-list'
    template: 'customers/templates/show/transactions_list'
    itemView: Show.TransactionsItemView
    itemViewContainer: 'tbody'

  class Show.CustomerFullView extends Marionette.ItemView
    template: 'customers/templates/show/customer_full_view'

    initialize: ->
      @transaction_collection = new App.Entities.TransactionsCollection(@model.attributes.transactions)

    onShow: ->
      transactions_view = new Show.TransactionsListView
        collection: @transaction_collection
        # @.$el.find('#transaction-data-region').show transactions_view
      @.$el.find('#transaction-data-region').html(transactions_view.render().el)
