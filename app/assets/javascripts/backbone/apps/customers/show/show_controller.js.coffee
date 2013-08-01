@SaleTrackr.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base
    initialize: (customerId) ->
      fetchingCustomer = App.request 'customer:fetch', customerId

      $.when(fetchingCustomer).done (customer) =>
        console.log 'completed retrieving customer', customer

        customer.on 'updated', ->
          App.vent.trigger 'customer:updated', customer

        transactions = @buildTransactions customer.attributes.transactions

        @layout = new Show.CustomerLayout

        @listenTo @layout, 'show', =>
          @panelRegion customer
          @customerRegion customer
          @transactionsRegion transactions

        @show @layout

    buildTransactions: (collection) ->
      transactions = new App.Entities.TransactionsCollection collection
      transactions

    customerRegion: (customer) ->
      view = new Show.CustomerFullView model: customer
      @layout.customerRegion.show view

    panelRegion: (customer) ->
      view = new Show.CustomerPanel
      @listenTo view, "edit:customer:button:clicked", =>
        @editCustomer customer

      @listenTo view, "add:purchase:button:clicked", =>
        App.vent.trigger "sale:new", customer.id, customer

      @listenTo view, "add:payment:button:clicked", =>
        payment = App.request "new:payment:entity", customer.id
        paymentView = App.request "add:payment:form", payment


        @listenTo paymentView, "form:cancel", ->
          App.vent.trigger "payment:cancel", customer

        @listenTo payment, "created", ->
          App.vent.trigger "payment:created", customer

        paymentFormView = App.request "form:wrapper", paymentView
        @layout.actionsRegion.show paymentFormView

      @listenTo view, "delete:customer:button:clicked", =>
        App.vent.trigger "customer:destroyed", customer

      @layout.panelRegion.show view

    transactionsRegion: (transactions) ->
      view = new Show.TransactionsList collection: transactions
      @layout.transactionsRegion.show view

    editCustomer: (customer) ->
      editView = App.request "edit:customer:form", customer
      @listenTo editView, "form:cancel", ->
        App.vent.trigger "customer:cancel", customer

      formView = App.request "form:wrapper", editView

      @layout.customerRegion.show formView
