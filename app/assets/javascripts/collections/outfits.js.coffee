Outfitter.Collections.Outfits = Backbone.Collection.extend
  model: Outfitter.Models.Outfit
  url: '/outfits'

  parse: (response) ->
    console.log("in Outfitter.Collections.Outfits#parse, response is", response)
    @.pagination = response.pagination
    return response.outfits

  fetchPage: (page) ->
    @.url = "/outfits/page/#{page}"
    @.fetch()
