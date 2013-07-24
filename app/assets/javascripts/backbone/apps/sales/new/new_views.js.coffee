@SaleTrackr.module "SalesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Layout extends Marionette.Layout
    template: 'sales/templates/new/layout'

    regions:
      saleRegion: '#sale'
      actionsRegion: '#actions'

  class New.Actions extends Marionette.ItemView
    template: 'sales/templates/new/actions'

  class New.Empty extends Marionette.ItemView
    template: 'sales/templates/new/empty'
    className: 'well'

  class New.ListItem extends Marionette.ItemView
    tagName: 'tr'
    template: 'sales/templates/new/list_item'

  class New.Sale extends Marionette.CompositeView
    tagName: 'table'
    className: 'table table-striped'
    template: 'sales/templates/new/sale'
    itemView: New.ListItem
    itemViewContainer: 'tbody'
    emptyView: New.Empty



