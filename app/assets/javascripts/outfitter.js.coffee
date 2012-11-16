window.Outfitter =
  Models: {}
  Collections: {}
  Views:
    Outfits: {}
  Routers: {}

  initialize: (data) ->

    data.outfits = new Outfitter.Collections.Outfits(data.outfits)

    new Outfitter.Routers.Outfits(data)
    Backbone.history.start()
