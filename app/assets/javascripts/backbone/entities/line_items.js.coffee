@SaleTrackr.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.LineItem extends Entities.Model
    urlRoot: ->
      Routes.api_line_items_path()

  class Entities.LineItems extends Backbone.Collection
    model: Entities.LineItem

    url: ->
      Routes.api_line_items_path()

  API =
    newLineItem: (saleId) ->
      new Entities.LineItem
        sale_id: saleId

  App.reqres.setHandler 'new:item:entity', (saleId) ->
    API.newLineItem saleId
