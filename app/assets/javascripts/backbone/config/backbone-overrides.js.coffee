Backbone.old_sync = Backbone.sync

Backbone.sync = (method, model, options) ->
  new_options = _.extend
    beforeSend: (xhr) ->
      token = gon.authToken
      xhr.setRequestHeader('X-AUTH-TOKEN', token) if token
  , options

  Backbone.old_sync(method, model, new_options)

# Backbone.sync = function(method, model, options) {
#   var new_options =  _.extend({
#       beforeSend: function(xhr) {
#           var token = gon.authToken;
#           if (token) xhr.setRequestHeader('X-AUTH-TOKEN', token);
#       }
#   }, options)
#   Backbone.old_sync(method, model, new_options);
# };
