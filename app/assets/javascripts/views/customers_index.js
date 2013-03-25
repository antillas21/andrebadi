App.Views.CustomersIndex = Backbone.View.extend({
  tagName: 'ul',
  className: "ui-listview ui-listview-inset ui-corner-all ui-shadow",

  attributes: {
    "data-role": "listview",
    "data-inset": "true"   
  },

  initialize: function() {
    this.collection.on('add', this.addOne, this);
    this.collection.on('reset', this.render, this);
  },

  render: function() {
    // this.$el.html(JST['customers/index']());
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
    $(this.el).append(customerLi.render().el);
  }
});
