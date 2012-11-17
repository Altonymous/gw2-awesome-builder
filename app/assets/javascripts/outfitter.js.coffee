window.Outfitter =
  Models: {}
  Collections: {}
  Views:
    Outfits: {}
  Routers: {}


  initialize: (data) ->
    @.Router = new Outfitter.Routers.Outfits()
    Backbone.history.start(root: "/outfits/")
