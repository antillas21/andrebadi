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
      formView = App.request "form:wrapper", newView

      newView.on "form:cancel", =>
        @layout.newRegion.close()

      @layout.newRegion.show formView

    getNewView: ->
      new List.New

    panelRegion: (customers) ->
      panelView = @getPanelView customers
      panelView.on "add:customer:button:clicked", (customers) =>
        @newRegion @customers

      panelView.on "search:customers", (panel) =>
        console.log panel.view.el
        data = Backbone.Syphon.serialize panel.view
        console.log data
        @filterCustomers data

      @layout.panelRegion.show panelView

    getPanelView: (customers) ->
      new List.Panel
        collection: @customers

    filterCustomers: (filter) ->
      console.log "filterCustomers", filter
      unless _.isEmpty(filter.query)
        filteredCustomers = @getFilteredCustomers filter.query
        @customersRegion filteredCustomers
      else
        console.log "@customers", @customers
        @customersRegion @customers

    getFilteredCustomers: (search) ->
      matched = @customers.query
        name:
          $likeI: search
      new App.Entities.CustomersCollection matched

