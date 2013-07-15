@SaleTrackr.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends Marionette.ItemView
    # className: 'js-form new'
    template: 'customers/templates/new/form'

    form:
      buttons:
        primary: "Add"

    # triggers:
    #   "click #cancel" : "form:cancel:button:clicked"
