@SaleTrackr.module "PaymentsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base
    initialize: (id) ->
      App.request "payment:fetch", id, (payment) =>
        console.log payment

        payment.on "updated", ->
          App.vent.trigger "payment:updated", payment

        @layout = @getLayout payment

        @listenTo @layout, "show", =>
          @paymentRegion payment
          @actionsRegion payment

        @show @layout

    onClose: ->
      console.log "closing controller", @

    getLayout: (payment) ->
      new Show.Layout
        model: payment

    paymentRegion: (payment) ->
      paymentView = @getPaymentView payment

      @layout.paymentRegion.show paymentView

    actionsRegion: (payment) ->
      actionsView = @getActionsView payment

      @listenTo actionsView, "payment:delete:clicked", =>
        App.vent.trigger "payment:destroyed", payment

      @listenTo actionsView, "edit:payment:clicked", =>
        @layout.actionsRegion.close()
        @editPayment payment

      @layout.actionsRegion.show actionsView

    getPaymentView: (payment) ->
      new Show.Payment
        model: payment

    getActionsView: (payment) ->
      new Show.Actions
        model: payment

    editPayment: (payment) ->
      editView = App.request "edit:payment:form", payment
      editView.on "form:cancel", ->
        App.vent.trigger "payment:edit:cancel", payment

      formView = App.request "form:wrapper", editView

      @layout.paymentRegion.show formView

