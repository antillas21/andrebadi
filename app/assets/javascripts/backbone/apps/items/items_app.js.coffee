@SaleTrackr.module 'ItemsApp', (ItemsApp, App, Backbone, Marionette, $, _) ->

  class ItemsApp.Router extends Marionette.AppRouter
    appRoutes:
      "line-items/new" : "newLineItem"

  API =
    newLineItem: ->
      console.log 'called newLineItem from the ItemsApp'

    newLineItemForm: (options = {}) ->
      console.log 'called a new form for a Line Item', options
      new ItemsApp.New.Controller(options).lineItemView

  App.addInitializer ->
    new ItemsApp.Router
      controller: API

  App.reqres.setHandler 'new:item:form:view', (item, items) ->
    API.newLineItemForm
      item: item
      items: items

  App.vent.on "item:created", (item, items) ->
    items.add item

