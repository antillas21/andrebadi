@SaleTrackr.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Payment extends Entities.Model
    urlRoot: ->
      Routes.api_payments_path()

    send_by_email: (opts = {}) ->
      model = @
      url = model.url() + '/email'
      options =
        url: url
        type: 'POST'

      _.extend options, opts

      (@.sync || Backbone.sync).call @, null, @, options

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

    getPayment: (paymentId) ->
      defer = $.Deferred()
      payment = new Entities.Payment
        id: paymentId

      payment.fetch
        success: (data) ->
          defer.resolve data

      defer.promise()

  App.reqres.setHandler "new:payment:entity", (customerId) ->
    new Entities.Payment
      customer_id: customerId

  App.reqres.setHandler "payments:fetch", ->
    API.fetchPayments()

  App.reqres.setHandler "payment:fetch", (paymentId) ->
    API.getPayment paymentId
