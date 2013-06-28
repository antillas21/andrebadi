@Badi.module "CustomersApp.New", (New, App, Backbone, Marionette, $, _) ->

  New.Controller =
    newCustomer: ->
      newView = @getNewView()
      newView

    getNewView: ->
      new New.Form
