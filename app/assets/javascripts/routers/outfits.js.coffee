Outfitter.Routers.Outfits = Backbone.Router.extend
  routes:
    "": "index",
    ":id": "show"

  index: ->
    @.collection = new Outfitter.Collections.Outfits()
    @.collection.fetch()

  show: ->

