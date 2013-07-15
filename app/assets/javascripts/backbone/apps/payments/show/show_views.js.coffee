@SaleTrackr.module "PaymentsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Payment extends Marionette.ItemView
    className: 'row'
    template: 'payments/templates/show/payment'

    modelEvents:
      "sync" : "render"
