@SaleTrackr.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends Marionette.ItemView
    template: 'customers/templates/new/form'

    form:
      buttons:
        primary: "Add"
