App.Views.CustomerAsListItem = Backbone.View.extend({
  attributes: {
    "data-corners": "false",
    "data-shadow": "false",
    "data-iconshadow": "true",
    "data-wrapperels": "div",
    "data-icon": "arrow-r",
    "data-iconpos": "right",
    "data-theme": "c"
  },

  tagName: 'li',
  className: "ui-btn ui-btn-icon-right ui-li-has-arrow ui-li ui-first-child ui-btn-up-c",

  render: function() {
    this.$el.html(JST['customers/list_item']({ model: this.model }));
    return this;
  }
});
