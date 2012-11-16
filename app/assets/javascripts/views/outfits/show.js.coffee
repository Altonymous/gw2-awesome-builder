Outfitter.Views.Outfits.Show = Backbone.View.extend

  initialize: (options) ->
    @.outfit = options.outfit

  render: ->
    this.$el.html JST['outfits/show']
      outfit: @.outfit.toJSON()
    return this

