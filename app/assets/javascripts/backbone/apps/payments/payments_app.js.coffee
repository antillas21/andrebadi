@SaleTrackr.module "PaymentsApp", (PaymentsApp, App, Backbone, Marionette, $, _) ->

  class PaymentsApp.Router extends Marionette.AppRouter
    appRoutes:
      "payments"            : "listPayments"
      "payments/:id"        : "showPayment"
      "payments/:id/edit"   : "editPayment"

  API =
    listPayments: ->
      console.log "Listing Payments from PaymentsApp"
      new PaymentsApp.List.Controller

    showPayment: (paymentId) ->
      console.log "Showing Payment", paymentId
      new PaymentsApp.Show.Controller paymentId

    editPayment: (options = {}) ->
      console.log "Edit Payment", options
      new PaymentsApp.Edit.Controller(options).editPaymentView

    newPayment: (options = {}) ->
      console.log "New Payment", options
      new PaymentsApp.New.Controller(options).paymentView

  App.addInitializer ->
    new PaymentsApp.Router
      controller: API

  App.reqres.setHandler "add:payment:form", (payment) ->
    API.newPayment
      payment: payment

  App.reqres.setHandler "edit:payment:form", (payment) ->
    API.editPayment
      payment: payment

  App.vent.on "payment:destroyed", (payment) ->
    payment.destroy()
    App.navigate( Routes.payments_path(), trigger: true )

  App.vent.on "payment:edit:cancel payment:updated", (payment) ->
    API.showPayment payment.id
