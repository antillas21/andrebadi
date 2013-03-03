var AndreBadiApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
    new AndreBadiApp.Routers.Customers();
    Backbone.history.start();
  },
}

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

// Models
AndreBadiApp.Models.Customer = Backbone.Model.extend({
});

AndreBadiApp.Models.Payment = Backbone.Model.extend({});

AndreBadiApp.Models.Purchase = Backbone.Model.extend({});

AndreBadiApp.Models.PurchaseItem = Backbone.Model.extend({});


// Collections
AndreBadiApp.Collections.CustomersList = Backbone.Collection.extend({
  model: AndreBadiApp.Models.Customer,
  url: '/api/customers'
});

// Views
AndreBadiApp.Views.Customers = Backbone.View.extend({});

// Routers
AndreBadiApp.Routers.Customers = Backbone.Router.extend({});
