@SaleTrackr.module 'ItemsApp.New', (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { item, items } = options
      console.log item, items

      newView = @getNewView item, items
      @lineItemView = newView

    getNewView: (item, items) ->
      new New.Form
        model: item
        collection: items
