App.Views.CustomersIndex = Backbone.View.extend({

  initialize: function() {
    this.collection.on('add', this.addOne, this);
    this.collection.on('reset', this.render, this);
  },

  render: function() {
    this.$el.html(JST['customers/index']());
    this.addAll();

    return this;
  },

  addAll: function() {
    this.collection.each(function(customer) {
      this.addOne(customer);
    }, this);
  },

  addOne: function(customer) {
    var customerLi = new App.Views.CustomerAsListItem({ model: customer });
    this.$('tbody').append(customerLi.render().el);
  }
});
