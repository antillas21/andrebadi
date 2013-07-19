@SaleTrackr.module "SalesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends Marionette.Layout
    template: 'sales/templates/list/layout'

    regions:
      panelRegion: '#panel'
      salesRegion: '#sales'

  class List.Empty extends Marionette.ItemView
    template: 'sales/templates/list/empty'
    className: 'js empty well well-large'

  class List.Row extends Marionette.ItemView
    template: 'sales/templates/list/row'
    tagName: 'tr'

  class List.Table extends Marionette.CompositeView
    template: 'sales/templates/list/table'
    tagName: 'table'
    className: 'table table-striped'

    itemView: List.Row
    itemViewContainer: 'tbody'
    emptyView: List.Empty

    collectionEvents:
      "reset" : "render"

  class List.Panel extends Marionette.ItemView
    template: 'sales/templates/list/panel'
