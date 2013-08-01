@SaleTrackr.module "SalesApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends Marionette.Layout
    template: 'sales/templates/edit/layout'

    regions:
      headerRegion: '#header'
      saleRegion: '#sale'
      actionsRegion: '#actions'

  class Edit.Actions extends Marionette.ItemView
    template: 'sales/templates/edit/actions'

    triggers:
      'click #save-sale' : 'save:sale'
      'click #delete-sale' : 'sale:delete:clicked'

  class Edit.Empty extends Marionette.ItemView
    template: 'sales/templates/edit/empty'
    className: 'well'

  class Edit.ListItem extends Marionette.ItemView
    tagName: 'tr'
    template: 'sales/templates/edit/list_item'

  class Edit.Header extends Marionette.ItemView
    template: 'sales/templates/edit/header'

  class Edit.Sale extends Marionette.CompositeView
    tagName: 'table'
    className: 'table table-striped'
    template: 'sales/templates/edit/sale'
    itemView: Edit.ListItem
    itemViewContainer: 'tbody'
    emptyView: Edit.Empty



