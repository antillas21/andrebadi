App.Collections.Payments = Backbone.Collection.extend({
  model: App.Models.Payment,

  initialize: function(options) {
    this.options = options;
    this.customer_id = this.options.customer_id;
  },


  url: function() {
    return "/api/customers/" + this.customer_id + "/payments"
  }
})
