@Badi.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  Edit.Controller =
    editCustomer: (customerId)->
      customer = App.request "customer:get", customerId

      editView = @getEditView customer

      App.mainRegion.show editView

    getEditView: (customer) ->
      new Edit.EditCustomerForm
        model: customer
