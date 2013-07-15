@SaleTrackr.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.EditCustomerForm extends Marionette.ItemView
    template: 'customers/templates/edit/form'
    tagName: "fieldset"

    form:
      buttons:
        primary: "Update"
        cancel: "Cancel"
        placement: "left"
