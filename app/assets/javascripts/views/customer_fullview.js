App.Views.CustomerFullView = Backbone.View.extend({
  initialize: function() {
    this.model.on('change', this.render, this);
    this.model.recentPayments = this.model.get('recent_payments');
  },
  
  render: function() {
    this.$el.html(JST['customers/full_view']({ model: this.model }));
    return this;
  }
});
