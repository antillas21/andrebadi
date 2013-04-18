App.Models.Payment = Backbone.Model.extend({
  urlRoot: function() {
    var customer_id = this.get('customer_id')
    return "/api/customers/" + customer_id + "/payments"
  },

  idAttribute: 'id'
})
