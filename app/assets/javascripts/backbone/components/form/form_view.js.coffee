@SaleTrackr.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

  class Form.FormWrapper extends Marionette.Layout
    template: 'form/form'
    tagName: "form"
    className: "form"

    regions:
      formRegion: "#form-content"

    triggers:
      "submit" : "form:submit"
      "click #cancel" : "form:cancel"

    modelEvents:
      "change:_errors" : "changeErrors"
      "sync:start" : "syncStart"
      "sync:stop" : "syncStop"

    changeErrors: (model, errors, options) ->
      if @options.config.errors
        if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    removeErrors: ->
      @$('.error').removeClass("error").find("span").remove()


    addErrors: (errors) ->
      for name, array of errors
        @addError name, array[0]

    addError: (name, error) ->
      console.warn name, error
      el = @$("[name=#{name}]")
      sm = $("<span class='help-inline'>").text error
      el.after(sm).closest('.control-group').addClass "error"

    serializeData: ->
      footer: @options.config.footer
      buttons: @options.config.buttons

    onShow: ->
      _.defer =>
        @focusFirstInput() if @options.config.focusFirstInput

    focusFirstInput: ->
      @$(":input:visible:enabled:first").focus()

    syncStart: (model) ->
      console.log "sync start"
      @$el.find("input").attr("disabled", "disabled")
      @$el.find(".btn").addClass "disabled"

    syncStop: (model) ->
      console.log "sync stop"
      @$el.find("input").removeAttr "disabled"
      @$el.find(".btn").removeClass "disabled"
