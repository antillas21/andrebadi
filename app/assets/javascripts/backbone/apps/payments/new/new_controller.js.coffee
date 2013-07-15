@SaleTrackr.module "PaymentsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { payment } = options
      newView = @getView payment
      @paymentView = newView

    getView: (payment) ->
      new New.Form
        model: payment
