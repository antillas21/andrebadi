@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =
    listCustomers: ->
      customers = App.request "customers:fetch"

      @layout = @getLayoutView()

      @layout.on "show", =>
        @panelRegion()
        @customersRegion customers

      App.mainRegion.show @layout

    getLayoutView: ->
      new List.Layout

    customersRegion: (customers) ->
      customersView = @getCustomersView(customers)

      @layout.customerRegion.show customersView

    getCustomersView: (customers) ->
      new List.CustomerTable collection: customers

    newRegion: ->
      newView = App.request "new:customer:form:view"

      newView.on "form:cancel:button:clicked", =>
        @layout.newRegion.close()

      @layout.newRegion.show newView

    getNewView: ->
      new List.New

    panelRegion: ->
      panelView = @getPanelView()
      panelView.on "add:customer:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    getPanelView: ->
      new List.Panel
