App.Collections.Customers = Backbone.Collection.extend({
  model: App.Models.Customer,
  url: '/api/customers'
});
