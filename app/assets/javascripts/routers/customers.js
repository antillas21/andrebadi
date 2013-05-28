AndreBadiApp.Routers.Customers = Backbone.Router.extend({
  routes: {
    "": "index"
  },

  index: function() {
    alert('Hello from the Customers Router in Backbone');
  }
});
