@Badi.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends Marionette.ItemView
    className: 'js-form new'
    template: 'customers/templates/new/form'

    triggers:
      "click #cancel" : "form:cancel:button:clicked"
