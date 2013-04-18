App.Views.CustomersIndex = Backbone.Marionette.CompositeView.extend({
  template: 'customers/index',

  itemView: App.Views.CustomerAsListItem,

  itemViewContainer: 'tbody'
});
