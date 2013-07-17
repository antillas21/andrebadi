@SaleTrackr.module "PaymentsApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Form extends Marionette.ItemView
    template: 'payments/templates/edit/form'
    tagName: "fieldset"

    form:
      buttons:
        primary: 'Update'
