@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =
    listCustomers: ->
      @customers = App.request "customers:fetch"

      @layout = @getLayoutView()

      @layout.on "show", =>
        @panelRegion @customers
        @customersRegion @customers

      App.mainRegion.show @layout

    getLayoutView: ->
      new List.Layout

    customersRegion: (customers) ->
      customersView = @getCustomersView(customers)

      @layout.customerRegion.show customersView

    getCustomersView: (customers) ->
      new List.CustomerTable collection: customers

    newRegion: (customers) ->
      customer = App.request "new:customer:entity", customers

      customer.on "created", =>
        App.vent.trigger "customer:created", customer, customers
        @layout.newRegion.close()

      newView = App.request "new:customer:form:view", customer, @customers

      newView.on "form:cancel:button:clicked", =>
        @layout.newRegion.close()

      newView.on "form:submit", (form) =>
        data = Backbone.Syphon.serialize form.view
        model = form.model
        collection = form.collection

        @createModel collection, model, data

      @layout.newRegion.show newView

    getNewView: ->
      new List.New

    panelRegion: (customers) ->
      panelView = @getPanelView customers
      panelView.on "add:customer:button:clicked", (customers) =>
        @newRegion @customers

      @layout.panelRegion.show panelView

    getPanelView: (customers) ->
      new List.Panel
        collection: @customers

    createModel: (collection, model, data) ->
      model.save data
