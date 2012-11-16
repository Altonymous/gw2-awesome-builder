window.Outfitter =
  Models: {}
  Collections: {}
  Views:
    Outfits: {}
  Routers: {}

  initialize: (data) ->
    new Outfitter.Routers.Outfits(data)
    Backbone.history.start()
