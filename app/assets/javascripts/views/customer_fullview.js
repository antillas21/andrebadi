App.Views.CustomerFullView = Backbone.View.extend({
  initialize: function() {
    this.model.on('change', this.render, this);
  },
  
  render: function() {
    this.$el.html(JST['customers/full_view']({ model: this.model }));
    return this;
  }
});
