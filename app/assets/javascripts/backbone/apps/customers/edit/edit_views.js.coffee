@Badi.module "CustomersApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.EditCustomerForm extends Marionette.ItemView
    className: 'js-form edit'
    template: 'customers/templates/edit/form'

    modelEvents:
      "sync" : "render"
      "change:_errors" : "changeErrors"

    triggers:
      "click #cancel" : "form:cancel:button:clicked"
      "submit" : "form:submit"

    changeErrors: (model, errors, options) ->
      if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    addErrors: (errors = {}) ->
      for name, array of errors
        @addError name, array[0]

    addError: (name, error) ->
      console.warn name, error
      el = @$("[name='#{name}']")
      sm = $("<span class='help-inline'>").text(error)
      el.after(sm).closest(".control-group").addClass "error"

    removeErrors: ->
      @$(".error").removeClass("error").find("span").remove()
