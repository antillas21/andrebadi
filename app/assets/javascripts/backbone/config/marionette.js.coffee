Backbone.Marionette.Renderer.render = (template, data) ->
  path = HandlebarsTemplates["backbone/apps/" + template]

  unless path
    throw "Template #{template} not found!"

  path(data)
