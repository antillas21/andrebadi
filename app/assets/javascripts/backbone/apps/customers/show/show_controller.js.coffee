@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =
    showCustomer: (customerId) ->
      App.request "customer:fetch", customerId, (customer) =>

        transactions = @buildTransactions customer.attributes.transactions

        @layout = new Show.CustomerLayout

        @layout.on "show", =>
          @panelRegion customer
          @customerRegion customer
          @transactionsRegion transactions

        App.mainRegion.show @layout

    buildTransactions: (collection) ->
      transactions = new App.Entities.TransactionsCollection collection
      transactions

    customerRegion: (customer) ->
      view = new Show.CustomerFullView model: customer
      @layout.customerRegion.show view

    panelRegion: (customer) ->
      view = new Show.CustomerPanel
      view.on "edit:customer:button:clicked", =>
        @editCustomer customer

      view.on "add:purchase:button:clicked", =>
        App.request "add:purchase:form:view", customer.id

      view.on "add:payment:button:clicked", =>
        App.request "add:payment:form:view", customer.id

      @layout.panelRegion.show view

    transactionsRegion: (transactions) ->
      view = new Show.TransactionsList collection: transactions
      @layout.transactionsRegion.show view

    editCustomer: (customer) ->
      editView = App.request "edit:customer:form", customer

      editView.on "form:cancel:button:clicked", =>
        @layout.customerRegion.close()
        @customerRegion customer

      editView.on "form:submit", (form) =>
        data = Backbone.Syphon.serialize form.view
        @updateModel data, customer
        form.view.close()
        @customerRegion customer

      @layout.customerRegion.show editView

    updateModel: (data, customer) ->
      console.log data
      customer.save data
