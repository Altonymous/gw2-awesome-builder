Outfitter.Views.OutfitsIndex = Backbone.View.extend
  render: ->
    this.$el.html JST['outfits/index']
      outfits: this.collection
    return this
