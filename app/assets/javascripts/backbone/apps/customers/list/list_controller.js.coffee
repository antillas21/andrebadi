@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =
    listCustomers: ->
      customers = App.request "customers:fetch"

      @layout = @getLayoutView()

      @layout.on "show", =>
        @panelView()
        @customersRegion customers

      App.mainRegion.show @layout

    getLayoutView: ->
      new List.Layout

    customersRegion: (customers) ->
      customersView = @getCustomersView(customers)

      @layout.customerRegion.show customersView

    getCustomersView: (customers) ->
      new List.CustomerTable collection: customers

    panelView: ->
      panelView = @getPanelView()
      @layout.panelRegion.show panelView

    getPanelView: ->
      new List.Panel
