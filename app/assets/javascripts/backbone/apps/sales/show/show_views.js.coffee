@SaleTrackr.module "SalesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Sale extends Marionette.ItemView
    template: 'sales/templates/show/sale'

  class Show.Actions extends Marionette.ItemView
    template: 'sales/templates/show/actions'

  class Show.Layout extends Marionette.Layout
    template: 'sales/templates/show/layout'

    regions:
      headerRegion: '#header'
      saleRegion: '#sale'
      actionsRegion: '#actions'

