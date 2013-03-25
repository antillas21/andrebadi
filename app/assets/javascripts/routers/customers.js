App.Routers.Customers = Backbone.Router.extend({
  routes: {
    "": "index"
  },

  index: function() {
    var view = new App.Views.CustomersIndex({ collection: App.customers });
    view.render()
    $('#backbone-container').html(view.el);
    // $('#backbone-container').html(view.render().$el);
  }
});
