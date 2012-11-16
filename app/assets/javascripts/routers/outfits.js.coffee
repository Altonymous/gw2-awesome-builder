Outfitter.Routers.Outfits = Backbone.Router.extend
  routes:
    "": "index"
    ":id": "show"

  initialize: (options) ->
    @.collection = options.outfits

  index: ->
    view = new Outfitter.Views.Outfits.Index
      collection: @.collection
    $('.stats-outfits-container').html(view.render().$el)

  show: (id) ->
    console.log "woop"
    # outfit = @.collection.get(id)
    # outfit.fetch
    #   success: ->
    #     view = new Outfitter.Views.Outfits.Show
    #       collection: @.collection
    #       outfit: outfit
    #     $('#sidebar').html(view.render().$el)

  # fetchCollection: (callback) ->
  #   @.collection.fetch
  #     success: (response) ->
  #       callback(response)
  #   return this

  # theCallback = (response) ->
  #     collection: response

