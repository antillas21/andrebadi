@SaleTrackr.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Payment extends Entities.Model
    urlRoot: ->
      Routes.api_payments_path()

  class Entities.PaymentsCollection extends Backbone.QueryCollection
    url: ->
      Routes.api_payments_path()

    model: Entities.Payment

    comparator: (model) ->
      date = new Date(model.get('created_at'))
      -date.getTime()

  API =
    fetchPayments: ->
      payments = new Entities.PaymentsCollection
      payments.fetch
        reset: true

      payments

    getPayment: (id, cb) ->
      payment = new Entities.Payment
        id: id

      payment.fetch
        success: ->
          cb payment

  App.reqres.setHandler "new:payment:entity", (customerId) ->
    new Entities.Payment
      customer_id: customerId

  App.reqres.setHandler "payments:fetch", ->
    API.fetchPayments()

  App.reqres.setHandler "payment:fetch", (paymentId, cb) ->
    API.getPayment paymentId, cb
