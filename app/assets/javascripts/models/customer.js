App.Models.Customer = Backbone.Model.extend({
  urlRoot: '/api/customers',

  defaults: {
    name: 'John Doe',
    phone: '555-555-5555',
    email: 'john@example.com'
  }
});
