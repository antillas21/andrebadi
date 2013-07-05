@Badi.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

  class Form.Controller extends Marionette.Controller
    initialize: (options = {}) ->
      @contentView = options.view

      @formLayout = @getFormLayout options.config

      @listenTo @formLayout, "show", @formRegion
      @listenTo @formLayout, "close", @close
      @listenTo @formLayout, "form:submit", @formSubmit
      @listenTo @formLayout, "form:cancel", @formCancel

    onClose: ->
      console.log "onClose", @

    formCancel: ->
      @contentView.triggerMethod "form:cancel"

    formSubmit: ->
      data = Backbone.Syphon.serialize @formLayout
      if @contentView.triggerMethod("form:submit", data) isnt false
        model = @contentView.model
        @processFormSubmit data, model

    processFormSubmit: (data, model) ->
      model.save data

    getFormLayout: (options = {}) ->
      config = @getDefaultConfig _.result(@contentView, "form")

      new Form.FormWrapper
        config: config
        model: @contentView.model

    formRegion: ->
      @formLayout.formRegion.show @contentView

    getDefaultConfig: (config = {}) ->
      _.defaults config,
        footer: true
        focusFirstInput: true
        buttons: @getDefaultButtons config.buttons
        errors: true

    getDefaultButtons: (buttons = {}) ->
      _.defaults buttons,
        primary: "Add"
        cancel: "Cancel"
        placement: "right"

  App.reqres.setHandler "form:wrapper", (contentView, options = {}) ->
    throw new Error "No model found inside if form's contentView" unless contentView.model
    formController = new Form.Controller
      view: contentView
      config: options
    formController.formLayout
