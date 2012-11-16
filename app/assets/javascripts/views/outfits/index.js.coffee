Outfitter.Views.OutfitsIndex = Backbone.View.extend
  initialize: ->
    @.collection.on("reset", @.render)

  render: ->
    this.$el.html JST['outfits/index']
      outfits: this.collection
    return this

