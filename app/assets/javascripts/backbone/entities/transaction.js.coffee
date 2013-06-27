@Badi.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Transaction extends Backbone.Model

  class Entities.TransactionsCollection extends Backbone.Collection
    model: Entities.Transaction
    comparator: 'created_at'
