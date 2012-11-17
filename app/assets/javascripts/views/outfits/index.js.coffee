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

  render: ->
    console.log("Outfits.Index#render @", @.$el)
    @.$el.html JST['outfits/index'](outfits: @.collection)
    return @

  showOutfit: (event) ->
    console.log "showOutfit, ", @
    row = event.currentTarget
    outfitID = $(row).data("id")

    outfit = @.collection.get(outfitID)
    view = new Outfitter.Views.Outfits.Show(model: outfit, el: $('#sidebar'))

    outfit.fetch()

  gotoPage: (event) ->
    event.preventDefault();
    console.log "gotoPage"
    @.collection.navigate

  nextPage: (event) ->
    console.log "nextPage", @.pagination
    Outfitter.Router.navigate("2", trigger: true)

  prevPage: (event) ->
    console.log "prevPage"

  firstPage: (event) ->
    console.log "firstPage"

  lastPage: (event) ->
    console.log "lastPage"
