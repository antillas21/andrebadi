@SaleTrackr.module "SalesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.LineItem extends Marionette.ItemView
    tagName: 'tr'
    template: 'sales/templates/show/line_item'

  class Show.Empty extends Marionette.ItemView
    tagName: 'tr'
    template: 'sales/templates/show/empty'

  class Show.Sale extends Marionette.CompositeView
    template: 'sales/templates/show/sale'
    itemView: Show.LineItem
    itemViewContainer: 'tbody'
    emptyView: Show.Empty

    triggers:
      "click #delete-sale"   : "sale:delete:clicked"
      "click #edit-sale"     : "edit:sale:clicked"

  class Show.Actions extends Marionette.ItemView
    template: 'sales/templates/show/actions'

    triggers:
      "click #delete-sale"  : "sale:delete:clicked"
      "click #edit-sale"    : "edit:sale:clicked"
      "click #add-item"     : "add:item:clicked"

  class Show.Layout extends Marionette.Layout
    template: 'sales/templates/show/layout'

    regions:
      newItemRegion: '#new-item'
      saleRegion: '#sale'
      actionsRegion: '#actions'

