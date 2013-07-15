@SaleTrackr.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { customer } = options
      editView = @getEditView customer
      @editCustomerView = editView

    getEditView: (customer) ->
      new Edit.EditCustomerForm
        model: customer
