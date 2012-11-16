Outfitter.Routers.Outfits = Backbone.Router.extend
  routes:
    "": "index",
    ":id": "show"

  initialize: ->

  index: ->
    @.collection = new Outfitter.Collections.Outfits()
    @.fetchCollection(theCallback)

    view = new Outfitter.Views.OutfitsIndex
      collection: Outfitter.outfits
    $('.stats-outfits-container').html(view.render().$el)

  show: ->

  fetchCollection: (callback) ->
    @.collection.fetch
      success: (response) ->
        callback(response)
    return this

  theCallback = (response) ->
      collection: response

