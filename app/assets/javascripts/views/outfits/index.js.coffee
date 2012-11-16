Outfitter.Views.OutfitsIndex = Backbone.View.extend

   # events:
   #  "click .stat-row"       : "testers"

  initialize: ->
    @.collection.on("reset", @.render)

  render: ->
    this.$el.html JST['outfits/index']
      outfits: @.collection.toJSON()
    return this

  # testers: (s) ->
  #   console.log s
