@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends Marionette.Layout
    className: 'js-layout customers-layout'
    template: 'customers/templates/list/layout'

    regions:
      panelRegion: '#panel'
      customerRegion: '#customers'

  class List.CustomerRow extends Marionette.ItemView
    tagName: 'tr'
    className: 'js'
    template: 'customers/templates/list/row'

  class List.CustomerTable extends Marionette.CompositeView
    template: 'customers/templates/list/table'
    itemView: List.CustomerRow
    itemViewContainer: 'tbody'


  class List.Panel extends Marionette.ItemView
    className: 'js-view'
    template: 'customers/templates/list/panel'
