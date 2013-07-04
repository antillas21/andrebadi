@Badi.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.EditCustomerForm extends App.Components.Form
    template: 'customers/templates/edit/form'
