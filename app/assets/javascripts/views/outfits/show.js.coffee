Outfitter.Views.Outfits.Show = Backbone.View.extend

  # model: Outfitter.Models.Outfit

  initialize: (options) ->
    console.log("Outfits.Show#initialize @", @.model)
    @.model.on("change", @.render, @)

  render: ->
    console.log("Outfits.Show#render @", @)
    @.$el.html JST['outfits/show'](outfit: @.model.toJSON())
    return this

