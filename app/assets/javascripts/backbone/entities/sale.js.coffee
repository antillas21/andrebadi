@SaleTrackr.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Sale extends Backbone.Model
    urlRoot: ->
      Routes.api_sales_path()

  class Entities.SalesCollection extends Backbone.QueryCollection
    url: ->
      Routes.api_sales_path()

    model: Entities.Sale

    comparator: (model) ->
      date = new Date(model.get('created_at'))
      -date.getTime()

  API =
    fetchSale: (id) ->
      defer = $.Deferred()
      sale = new Entities.Sale
        id: id

      sale.fetch
        success: (data) ->
          defer.resolve sale

      defer.promise()

    fetchSales: ->
      sales = new Entities.SalesCollection
      sales.fetch
        reset: true

      sales

  App.reqres.setHandler "sale:fetch", (id) ->
    API.fetchSale id

  App.reqres.setHandler "sales:fetch", ->
    API.fetchSales()
