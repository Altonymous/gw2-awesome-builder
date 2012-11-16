Outfitter.Routers.Outfits = Backbone.Router.extend
  routes:
    "": "index",
    ":id": "show"

  initialize: (options) ->
    @.collection = options.outfit

  index: ->
    view = new Outfitter.Views.OutfitsIndex
      collection: @.collection
    $('.stats-outfits-container').html(view.render().$el)

  show: ->

  # fetchCollection: (callback) ->
  #   @.collection.fetch
  #     success: (response) ->
  #       callback(response)
  #   return this

  # theCallback = (response) ->
  #     collection: response

