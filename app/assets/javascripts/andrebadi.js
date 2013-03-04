(function(){
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
  }

  // Models
  App.Models.Customer = Backbone.Model.extend({
    urlRoot: 'api/customers'
  });

  App.Models.Payment = Backbone.Model.extend({});

  App.Models.Purchase = Backbone.Model.extend({});

  App.Models.PurchaseItem = Backbone.Model.extend({});


  // Collections
  App.Collections.Customers = Backbone.Collection.extend({
    model: App.Models.Customer,
    url: 'api/customers',
  });

  // Views
  App.Views.Customers = Backbone.View.extend({
    el: '#customers-list',

    render: function() {
      this.collection.each(function(customer) {
        var customerView = new App.Views.Customer({ model: customer });
        this.$el.append( customerView.render().el );
      }, this);

      return this;
    }

  });

  App.Views.Customer = Backbone.View.extend({
    tagName: 'li',
    template: _.template("<a href='#'><%= name %></a>"),

    render: function() {
      this.$el.html( this.template( this.model.toJSON() ) );
      return this;
    }
  });

})();

