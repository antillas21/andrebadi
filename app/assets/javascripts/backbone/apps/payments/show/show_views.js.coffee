@SaleTrackr.module "PaymentsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends Marionette.Layout
    template: 'payments/templates/show/layout'

    regions:
      headerRegion: '#payment-header'
      paymentRegion: '#payment-data'
      actionsRegion: '#payment-actions'
      messagesRegion: '#messages'

  class Show.Actions extends Marionette.ItemView
    template: 'payments/templates/show/actions'

    triggers:
      "click #delete-payment"   : "payment:delete:clicked"
      "click #edit-payment"     : "edit:payment:clicked"

    events:
      "click #email-payment" : "emailPayment"

    emailPayment: (e) ->
      e.preventDefault()
      @model.send_by_email()
      @displayEmailSentMessage()

    displayEmailSentMessage: ->
      @trigger "email:sent", @model

  class Show.Message extends Marionette.ItemView
    template: 'payments/templates/show/message'
    className: 'flash-message'

  class Show.Payment extends Marionette.ItemView
    template: 'payments/templates/show/payment'

    modelEvents:
      "sync" : "render"

    triggers:
      "click #delete-payment"   : "payment:delete:clicked"
      "click #edit-payment"     : "edit:payment:clicked"
