@SaleTrackr.module "ItemsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends Marionette.ItemView
    template: 'items/templates/new/form'

    form:
      buttons:
        primary: "Add"
