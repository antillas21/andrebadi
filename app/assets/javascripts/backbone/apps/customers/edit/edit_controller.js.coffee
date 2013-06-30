@Badi.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  Edit.Controller =
    editCustomer: (customer)->
      editView = @getEditView customer
      editView

    getEditView: (customer) ->
      new Edit.EditCustomerForm
        model: customer
