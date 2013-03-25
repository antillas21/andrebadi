Backbone.old_sync = Backbone.sync
Backbone.sync = function(method, model, options) {
  var new_options =  _.extend({
      beforeSend: function(xhr) {
          var token = $('meta[name="auth-token"]').attr('content');
          if (token) xhr.setRequestHeader('X-AUTH-TOKEN', token);
      }
  }, options)
  Backbone.old_sync(method, model, new_options);
};

window.App = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(data) {
    this.customers = new App.Collections.Customers;
    this.customers.fetch();
    new App.Routers.Customers({ customers: this.customers.toJSON() });
    Backbone.history.start();
  }
};

