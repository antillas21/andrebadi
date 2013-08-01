@SaleTrackr.module "SalesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      # App.navigate( Routes.new_sale_path() )
      { customer_id, customer } = options

      sale = App.request "new:sale:entity", customer_id
      sale.save()

      sale.on 'created', =>
        App.vent.trigger 'sale:created', sale


    #   @layout = @getLayout()

    #   @listenTo @layout, "show", =>
    #     @headerRegion customer
    #     @actionsRegion sale
    #   #   @saleRegion sale

    #   @show @layout

    # getLayout: ->
    #   new New.Layout

    # headerRegion: (customer) ->
    #   view = new New.Header
    #     model: customer
    #   @layout.headerRegion.show view

    # actionsRegion: (sale) ->
    #   actionsView = @getActionsView sale

    #   actionsView.on 'save:sale', =>
    #     sale.save()

    #   @layout.actionsRegion.show actionsView

    # saleRegion: (sale) ->
    #   saleView = @getSaleView sale
    #   @layout.saleRegion.show saleView

    # getSaleView: (sale) ->
    #   new New.Sale
    #     model: sale

    # getActionsView: (sale) ->
    #   new New.Actions
    #     model: sale
