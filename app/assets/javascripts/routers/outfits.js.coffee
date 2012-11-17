Outfitter.Routers.Outfits = Backbone.Router.extend
  routes:
    "": "index"
    ":id" : "page"

  initialize: (options) ->
    @.collection = new Outfitter.Collections.Outfits()
    @.view = new Outfitter.Views.Outfits.Index(collection: @.collection, el: $(".stats-outfits-container"))

  index: ->
    @.collection.fetch()


  show: (id) ->
    console.log "woop"
    # outfit = @.collection.get(id)
    # outfit.fetch
    #   success: ->
    #     view = new Outfitter.Views.Outfits.Show
    #       collection: @.collection
    #       outfit: outfit
    #     $('#sidebar').html(view.render().$el)

  page: (id) ->
    @.collection.fetchPage(2)

  # fetchCollection: (callback) ->
  #   @.collection.fetch
  #     success: (response) ->
  #       callback(response)
  #   return this

  # theCallback = (response) ->
  #     collection: response

