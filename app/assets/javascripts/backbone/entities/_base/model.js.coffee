@SaleTrackr.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Model extends Backbone.Model
    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true
        success: _.bind(@saveSuccess, @, isNew, options.collection)
        error: _.bind(@saveError, @)

      @unset "_errors"
      super data, options

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      super options

    saveSuccess: (isNew, collection) ->
      console.info "success", @, isNew
      if isNew
        collection.add @ if collection
        collection.trigger "model:created", @ if collection
        @trigger "created", @
      else
        collection ?= @collection
        collection.trigger "model:updated", @ if collection
        @trigger "updated", @

    saveError: (model, xhr, options) =>
      @set _errors: $.parseJSON(xhr.responseText)?.errors unless xhr.status is 500 or xhr.status is 404
      console.log @
