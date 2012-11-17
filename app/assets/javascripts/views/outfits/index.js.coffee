Outfitter.Views.Outfits.Index = Backbone.View.extend

  model: Outfitter.Models.Outfit

  events:
    "click .stats-row"      : "showOutfit"
    "click .page"           : "gotoPage"
    "click .next"           : "nextPage"
    "click .prev"           : "prevPage"
    "click .first"          : "firstPage"
    "click .last"           : "lastPage"

  initialize: ->
    console.log("Outfits.Index#initialize @", @)
    @.collection.on("reset", @.render, @)
    #@.collection.on("change", @.render, @)

  render: ->
    console.log("Outfits.Index#render @", @)
    @.$el.html JST['outfits/index'](outfits: @.collection)
    return @

  showOutfit: (event) ->
    row = event.currentTarget
    outfitID = $(row).data("id")

    # router = new Outfitter.Routers.Outfits
    #   outfits: @.collection
    # router.navigate(outfitID, true)

    outfit = @.collection.get(outfitID)
    outfit.fetch
      success: ->
        view = new Outfitter.Views.Outfits.Show
          collection: @.collection
          outfit: outfit
        $('#sidebar').html(view.render().$el)

  gotoPage: (event) ->
    event.preventDefault();
    console.log "gotoPage"
    @.collection.navigate

  nextPage: (event) ->
    console.log "nextPage"
    Outfitter.Router.navigate("2", trigger: true)

  prevPage: (event) ->
    console.log "prevPage"

  firstPage: (event) ->
    console.log "firstPage"

  lastPage: (event) ->
    console.log "lastPage"
