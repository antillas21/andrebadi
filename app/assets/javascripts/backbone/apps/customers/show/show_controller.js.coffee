@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =
    showCustomer: (customerId) ->

      App.request "customer:fetch", customerId, (customer) =>

        panelView = new Show.CustomerPanel
        panelView.on "edit:customer:button:clicked", =>
          App.vent.trigger "edit:customer:form", customer.id

        panelView.on "add:purchase:button:clicked", =>
          App.request "add:purchase:form:view", customer.id

        panelView.on "add:payment:button:clicked", =>
          App.request "add:payment:form:view", customer.id

        customer_view = new Show.CustomerFullView
                          model: customer

        transactions = Show.Controller.buildTransactions customer.attributes.transactions

        transactions_view = new Show.TransactionsList
                              collection: transactions

        layout = new Show.CustomerLayout

        layout.on "show", ->
          @panelRegion.show panelView
          @customerRegion.show customer_view
          @transactionsRegion.show transactions_view

        App.mainRegion.show layout

    buildTransactions: (collection) ->
      transactions = new App.Entities.TransactionsCollection collection
      transactions
