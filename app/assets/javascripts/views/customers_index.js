App.Views.CustomersIndex = Backbone.Marionette.CompositeView.extend({
  template: 'customers/index',

  itemView: App.Views.CustomerAsListItem,

  appendHtml: function(collectionView, itemView){
    collectionView.$("tbody").append(itemView.el);
  }
});
