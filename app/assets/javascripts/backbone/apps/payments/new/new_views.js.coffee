@SaleTrackr.module "PaymentsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends Marionette.ItemView
    template: 'payments/templates/new/form'

    form:
      buttons:
        primary: 'Add'
