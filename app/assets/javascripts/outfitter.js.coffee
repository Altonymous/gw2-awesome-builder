window.Outfitter =
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: ->
    new Outfitter.Routers.Outfits()
    Backbone.history.start()
