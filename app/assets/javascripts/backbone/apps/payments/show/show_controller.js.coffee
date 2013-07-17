@SaleTrackr.module "PaymentsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base
    initialize: (id) ->
      payment = App.request "payment:fetch", id
      console.log payment

      paymentView = @getPaymentView payment

      @listenTo paymentView, "payment:delete:clicked", =>
        App.vent.trigger "payment:destroyed", payment

      @show paymentView

    onClose: ->
      console.log "closing controller", @

    getPaymentView: (payment) ->
      new Show.Payment
        model: payment

