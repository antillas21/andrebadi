do (Marionette) ->
  _.extend Marionette.Renderer,

    lookups: ["backbone/apps/", "backbone/templates/"]

    render: (template, data) ->
      path = @getTemplate template
      throw "Template #{template} not found!" unless path
      path(data)

    getTemplate: (template) ->
      for lookup in @lookups
        return HandlebarsTemplates[lookup + template] if HandlebarsTemplates[lookup + template]
