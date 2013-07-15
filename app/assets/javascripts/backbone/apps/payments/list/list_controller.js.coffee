@SaleTrackr.module "PaymentsApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base
    initialize: ->
      @payments = App.request "payments:fetch"
      window.payments = @payments

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @panelRegion()
        @paymentsRegion @payments

      @show @layout

    onClose: ->
      console.info "closing controller", @

    getLayoutView: ->
      new List.Layout

    panelRegion: ->
      panelView = @getPanelView @payments

      @layout.panelRegion.show panelView

    getPanelView: (payments) ->
      new List.Panel
        collection: payments

    paymentsRegion: (payments) ->
      paymentsView = @getPaymentsView payments
      @layout.paymentsRegion.show paymentsView

    getPaymentsView: (payments) ->
      new List.PaymentsTable
        collection: payments
