@Badi = do (Backbone, Marionette) ->
  App = new Marionette.Application


  App.on "initialize:before", (options) ->
    App.addRegions
      mainRegion: options.appContainer

  App.on "initialize:after", ->
    if Backbone.history
      Backbone.history.start()

  App
