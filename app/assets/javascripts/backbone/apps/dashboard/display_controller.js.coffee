@SaleTrackr.module "DashboardApp.Display", (Display, App, Backbone, Marionette, $, _) ->

  Display.Controller =
    showDashboard: ->
      console.log "called showDashboard from DashboardApp.Display.Controller"
