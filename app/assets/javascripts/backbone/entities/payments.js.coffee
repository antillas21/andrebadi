@SaleTrackr.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Payment extends Entities.Model
    urlRoot: ->
      Routes.api_payments_path()

  class Entities.PaymentsCollection extends Backbone.QueryCollection
    url: ->
      Routes.api_payments_path()

  App.reqres.setHandler "new:payment:entity", (customerId) ->
    new Entities.Payment
      customer_id: customerId
