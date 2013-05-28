@Badi.module "DashboardApp", (DashboardApp, App, Backbone, Marionette, $, _) ->

  class DashboardApp.Router extends Marionette.AppRouter
    appRoutes:
      "dashboard" : "showDashboard"


  API =
    showDashboard: ->
      DashboardApp.Display.Controller.showDashboard()

  App.addInitializer ->
    new DashboardApp.Router
      controller: API
