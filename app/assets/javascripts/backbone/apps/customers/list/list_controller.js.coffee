@Badi.module "CustomersApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base
    initialize: ->
      @customers = App.request "customers:fetch"

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @panelRegion @customers
        @customersRegion @customers

      @show @layout

    onClose: ->
      console.info "closing controller", @

    getLayoutView: ->
      new List.Layout

    customersRegion: (customers) ->
      customersView = @getCustomersView(customers)

      @layout.customerRegion.show customersView

    getCustomersView: (customers) ->
      new List.CustomerTable collection: customers

    newRegion: (customers) ->
      customer = App.request "new:customer:entity", customers

      newView = App.request "new:customer:form:view", customer, @customers
      console.log newView
      formView = App.request "form:wrapper", newView

      @listenTo customer, "created", =>
        App.vent.trigger "customer:created", customer, customers
        newView.close()
        @layout.newRegion.close()

      @listenTo newView, "form:cancel", =>
        newView.close()
        @layout.newRegion.close()

      @layout.newRegion.show formView

    getNewView: ->
      new List.New

    panelRegion: (customers) ->
      panelView = @getPanelView customers
      @listenTo panelView, "add:customer:button:clicked", (customers) =>
        @newRegion @customers

      @listenTo panelView, "search:customers", (panel) =>
        data = Backbone.Syphon.serialize panel.view
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
        @customersRegion @customers

    getFilteredCustomers: (search) ->
      matched = @customers.query
        name:
          $likeI: search
      new App.Entities.CustomersCollection matched

