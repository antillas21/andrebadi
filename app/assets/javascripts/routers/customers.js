App.Routers.Customers = Backbone.Router.extend({
  routes: {
    "customers": "index",
    "customers/:id": "show"
  },

  index: function() {
    var view = new App.Views.CustomersIndex({ collection: App.customers });
    $('#backbone-container').html(view.render().$el);
  },

  show: function(id) {
    $('#backbone-container').html("");
    var customer = new App.Models.Customer({ id: id });
    customer.fetch();
    var view = new App.Views.CustomerFullView({ model: customer });
    $('#backbone-container').html(view.render().$el);
    console.log(view.render().el);
  }
});
