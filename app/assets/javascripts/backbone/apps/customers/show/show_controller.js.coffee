@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =
    showCustomer: (customerId) ->
      App.request "customer:fetch", customerId, (customer) =>

        customer_view = new Show.CustomerFullView
                          model: customer

        transactions = Show.Controller.buildTransactions customer.attributes.transactions

        transactions_view = new Show.TransactionsList
                              collection: transactions

        layout = new Show.CustomerLayout

        layout.on "show", ->
          @customerRegion.show customer_view
          @transactionsRegion.show transactions_view

        App.mainRegion.show layout

    buildTransactions: (collection) ->
      transactions = new App.Entities.TransactionsCollection collection
      transactions
