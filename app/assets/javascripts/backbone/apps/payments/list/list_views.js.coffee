@SaleTrackr.module "PaymentsApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Payments extends Marionette.CompositeView

  class List.Layout extends Marionette.Layout
    template: 'payments/templates/list/layout'

    regions:
      panelRegion     : '#panel'
      paymentsRegion  : '#payments'
      newRegion       : '#new'

  class List.Panel extends Marionette.ItemView
    template: 'payments/templates/list/panel'

  class List.Empty extends Marionette.ItemView
    className: 'js empty well well-large'
    template: 'payments/templates/list/empty'

  class List.PaymentRow extends Marionette.ItemView
    template  : 'payments/templates/list/row'
    tagName   : 'tr'

  class List.PaymentsTable extends Marionette.CompositeView
    template            : 'payments/templates/list/table'

    itemView            : List.PaymentRow
    itemViewContainer   : 'tbody'
    emptyView           : List.Empty
