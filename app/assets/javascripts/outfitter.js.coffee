window.Outfitter =
  Models: {}
  Collections: {}
  Views:
    Outfits: {}
  Routers: {}

  initialize: (data) ->
    new Outfitter.Routers.Outfits
      outfits: new Outfitter.Collections.Outfits(data.outfits)
    Backbone.history.start()
