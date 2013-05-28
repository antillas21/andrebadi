@Badi.module "CustomersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.CustomerFullView extends Marionette.ItemView
    template: 'customers/templates/show/customer_full_view'
