var AndreBadiApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function(data) {
    var customers = new AndreBadiApp.Collections.Customers(data.customers);
    new AndreBadiApp.Routers.Customers({customers: customers});
    Backbone.history.start();
  }
} || {};
