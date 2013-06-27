@Badi = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.rootRoute = Routes.dashboard_path()

  App.on "initialize:before", (options) ->
    App.addRegions
      mainRegion: options.appContainer

  App.on "initialize:after", ->
    @startHistory()
    @navigate( @rootRoute, trigger: true ) unless @getCurrentRoute()
    # if Backbone.history
    #   Backbone.history.start()

  App
