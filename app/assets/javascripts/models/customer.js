var Customer = Backbone.Model.extend({
  urlRoot: '/customers',

  defaults: {
    balance: 0
  }
});
