Outfitter.Collections.Outfits = Backbone.Collection.extend
  model: Outfitter.Models.Outfit
  url: '/outfits'
  parse: (response) ->
    console.log JSON.stringify response
