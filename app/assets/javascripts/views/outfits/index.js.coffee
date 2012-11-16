Outfitter.Views.Outfits.Index = Backbone.View.extend

  model: Outfitter.Models.Outfit

  events:
    "click .stats-row"       : "showOutfit"

  initialize: ->
    @.collection.on("reset", @.render)

  render: ->
    this.$el.html JST['outfits/index']
      outfits: @.collection.toJSON()
    return this

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

