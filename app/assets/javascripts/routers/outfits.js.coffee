Outfitter.Routers.Outfits = Backbone.Router.extend
  routes:
    "": "index",
    ":id": "show"

  initialize: (data) ->
    console.log(data)
    # @.collection = new Outfitter.Collections.Outfits(data.outfits)

  index: ->

    # @.fetchCollection(theCallback)

  show: ->

  fetchCollection: (callback) ->
    @.collection.fetch
      success: (response) ->
        callback(response)
    return this

  theCallback = (response) ->
    view = new Outfitter.Views.OutfitsIndex
      collection: response

    $('.stats-outfits-container').html(view.render().$el)
