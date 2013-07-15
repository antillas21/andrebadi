@SaleTrackr.module "PaymentsApp", (PaymentsApp, App, Backbone, Marionette, $, _) ->

  class PaymentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "payments"            : "listPayments"
      "payments/:id"        : "showPayment"
      "payments/:id/edit"   : "editPayment"

  API =
    listPayments: ->
      console.log "Listing Payments from PaymentsApp"

    showPayment: (options = {}) ->
      console.log "Showing Payment", options

    editPayment: (options = {}) ->
      console.log "Edit Payment", options

    newPayment: (options = {}) ->
      console.log "New Payment", options
      new PaymentsApp.New.Controller(options).paymentView

  App.addInitializer ->
    new PaymentsApp.Router
      controller: API

  App.reqres.setHandler "add:payment:form", (payment) ->
    # console.log 'catched call to payment form for customer with id ' + payment
    API.newPayment
      payment: payment
