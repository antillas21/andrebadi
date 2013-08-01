@SaleTrackr.module 'SalesApp.Edit', (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      { id } = options

      fetchingSale = App.request 'sale:fetch', id

      $.when(fetchingSale).done (sale) =>
        App.navigate( Routes.edit_sale_path(id) )
        console.log 'fetched', sale

        @layout = @getLayout()

        @listenTo @layout, 'show', =>
          @headerRegion sale
          @actionsRegion sale

        @show @layout

    getLayout: ->
      new Edit.Layout

    headerRegion: (sale) ->
      headerView = new Edit.Header
        model: sale

      @layout.headerRegion.show headerView

    actionsRegion: (sale) ->
      actionsView = new Edit.Actions
        model: sale

      actionsView.on 'save:sale', ->
        console.log 'we need to Syphon all data and save Sale', sale

      actionsView.on 'sale:delete:clicked', ->
        App.vent.trigger 'sale:destroyed', sale

      @layout.actionsRegion.show actionsView
