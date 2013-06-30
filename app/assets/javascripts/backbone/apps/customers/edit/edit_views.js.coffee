@Badi.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.EditCustomerForm extends Marionette.ItemView
    className: 'js-form edit'
    template: 'customers/templates/edit/form'

    modelEvents:
      "sync" : "render"

    triggers:
      "click #cancel" : "form:cancel:button:clicked"
