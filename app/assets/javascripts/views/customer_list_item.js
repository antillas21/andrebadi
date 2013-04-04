App.Views.CustomerAsListItem = Backbone.View.extend({
  tagName: 'tr',

  render: function() {
    this.$el.html(JST['customers/list_item']({ model: this.model }));
    return this;
  }
});
