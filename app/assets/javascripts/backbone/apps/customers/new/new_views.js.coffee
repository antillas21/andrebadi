@Badi.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends App.Components.Form
    # className: 'js-form new'
    template: 'customers/templates/new/form'

    # triggers:
    #   "click #cancel" : "form:cancel:button:clicked"
