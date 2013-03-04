(function (window, $) {

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

  // Mustache style
  _.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
  };

  window.App = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
  };

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
    url: 'api/customers'
  });

  // Views
  App.Views.Customer = Backbone.View.extend({
    tagName: 'li',

    template: _.template("<a href='#'>{{ name }}</a>"),

    render: function() {
      this.$el.html(this.template(this.model.toJSON()));

      return this;
    }
  });

  // [favrik] this was the only way I could find to actually append a list
  // couldn't just append links without an anchor hmmmm :/
  App.Views.CustomerList = Backbone.View.extend({
    initialize: function () {
      this.model.bind('reset', this.render, this);
    },

    render: function (eventName) {
      this.$el.empty();

      this.model.each(function (customer) {
        this.$el.append(new App.Views.Customer({ model: customer}).render().el);
      }, this);

      return this;
    }
  });

  App.Views.Customers = Backbone.View.extend({
    initialize: function () {
      this.listenTo(this.options.customers, { 'reset': this.render });
    },

    template: _.template($('#customers').html()),

    render: function (eventName) {
      this.$el.html(this.template());
      // [favrik] the "magic" happens when we pass the 'el' option with selecting an element with context
      this.listView = new App.Views.CustomerList({ el: $('ul#customerList', this.$el), model: this.options.customers });
      this.listView.render();

      return this;
    }
  });

  // Routers
  App.BaseRouter = Backbone.Router.extend({
    changePage: function (page) {
      $(page.el).attr('data-role', 'page');

      page.render();

      $('body').append($(page.el));

      var transition = $.mobile.defaultPageTransition;

      if (this.firstPage) {
        transition = 'none';
        this.firstPage = false;
      }

      $.mobile.changePage($(page.el), {changeHash:false, transition: transition});
    }
  });

  App.Routers.Customers = App.BaseRouter.extend({
    routes: {
      'customers': 'customers'
    },

    customers: function () {
      this.changePage(new App.Views.Customers({'customers': customers}));
    }
  });

  $(function () {
    console.log('initialized');
    var customersRouter = new App.Routers.Customers();

    // TODO: make this more resilient

    $(document).on('click', "a[href^='/']", function(ev) {
        ev.preventDefault();
        var href = $(ev.currentTarget).attr("href");
        res = customersRouter.navigate(href, { trigger: true });
        return false;
    });

    Backbone.history.start({ pushState: true, silent: true, hashChange: false });
  });

})(window, jQuery);
