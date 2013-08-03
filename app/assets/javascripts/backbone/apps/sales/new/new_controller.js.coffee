@SaleTrackr.module "SalesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { customer_id, customer } = options

      sale = App.request "new:sale:entity", customer_id
      sale.save()

      sale.on 'created', =>
        App.vent.trigger 'sale:created', sale
