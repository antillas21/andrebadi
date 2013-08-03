@SaleTrackr.module "SalesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.LineItem extends Marionette.ItemView
    tagName: 'tr'
    template: 'sales/templates/show/line_item'

    triggers:
      'click a.destroy-link' : 'item:remove'

  class Show.Empty extends Marionette.ItemView
    tagName: 'tr'
    template: 'sales/templates/show/empty'

  class Show.SaleItems extends Marionette.CompositeView
    className: 'sale-details'
    template: 'sales/templates/show/sale_items'
    itemView: Show.LineItem
    itemViewContainer: 'tbody'
    emptyView: Show.Empty

  class Show.SaleTotals extends Marionette.ItemView
    template: 'sales/templates/show/sale_totals'

    modelEvents:
      "change" : "render"

  class Show.Sale extends Marionette.CompositeView
    collectionEvents:
      "add" : "updateTotal"

    modelEvents:
      "reset" : "render"

    template: 'sales/templates/show/sale'
    itemView: Show.LineItem
    itemViewContainer: 'tbody'
    emptyView: Show.Empty

    updateTotal: ->
      console.log 'should update totals'
      @model.fetch
        reset: true

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

  class Show.SaleLayout extends Marionette.Layout
    template: 'sales/templates/show/sale_layout'

    regions:
      itemsRegion: '#line-items'
      totalsRegion: '#totals'

