@Badi = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.rootRoute = Routes.dashboard_path()

  App.on "initialize:before", (options) ->
    App.addRegions
      mainRegion: options.appContainer

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.on "initialize:after", ->
    @startHistory()

  App
