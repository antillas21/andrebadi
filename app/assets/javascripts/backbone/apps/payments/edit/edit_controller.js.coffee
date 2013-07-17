@SaleTrackr.module "PaymentsApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { payment } = options

      editView = @getEditView payment
      @editPaymentView = editView

    getEditView: (payment) ->
      new Edit.Form
        model: payment
