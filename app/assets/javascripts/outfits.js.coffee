# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  setup = (@container) ->
    setupTable()
    setupSliders()
    init()


  init = (router) ->
    Outfitter.initialize(Outfitter.Routers.Outfits)

  setupTable = ->
    $('#stats').fauxtable
      items: '>:not(.nosort)',
      placeholder: 'placeholder',
      helper: '.stats-slider',
      stop: (e, ui) ->
        highlightTableColumn(ui.item.index()+1)
      change: (e, ui) ->
        handleTableEndCorners()

  setupSliders = ->
    $.each $(".slider-range" ), ->
      name = $(this).data("name")

      $(this).slider
        orientation: "vertical",
        range: true,
        step: 5,
        values: [ 0, 100 ],
        slide: ( event, ui ) ->
          $(".slider-amount #slider-" + name).text ui.values[0] + " - " + ui.values[1]
      .height(150)

      rangeIndicator = $(".slider-amount #slider-" + name)
      rangeIndicator.text $(this).slider("values", 0) + " - " + $(this).slider("values", 1)

  highlightTableColumn = (i) ->
    setTimeout ->
      $(".stats-row .stats-item:nth-child("+i+")").effect("highlight", 400)
      $(".stats-header .stats-slider:nth-child("+i+")").effect("highlight")
      $(".fix-me").removeClass('fix-me')
    , 100

  handleTableEndCorners = ->
    lastItem = $(".stats-header .stats-slider:last-child")
    prevItem = $(".ui-sortable-helper").prev()

    if lastItem.hasClass("ui-sortable-helper") &&
    lastItem.prev().hasClass('stats-slider')
      prevItem.addClass('fix-me')
    else
      $(".fix-me").removeClass('fix-me')

  # handleOutfitClick = (item) ->
  #   outfitID = item.data("id")
  #   console.log outfitID
  #   bb = getJSON "outfits", outfitID
  #   console.log bb

  #   # helm_id, shoulders_id, coat_id, legs_id, gloves_id, boots_id

  #   $.ajax
  #     url: "/outfits/" + outfitID + ".json",
  #     success: (data) ->
  #       console.log "ajax: " + data
  #       return data


    # theView = Backbone.View.extend
    #   initialize: ->
    #     this.collection = new ArmorsCollection()
    #     this.collection.bind("reset", this.render, this)
    #     this.collection.bind("change", this.render, this)
    #     this.collection.fetch()
    #   ,
    #   render: ->
    #     alert("test" + this.collection.toJSON());
    # myView = new theView();

  # getArmor = (obj, key, val) ->
  #   $.grep obj, (item) ->
  #     console.log item.armor[key]
  #     return item.armor.key == val


  # getJSON = (path, id) ->

  #   ArmorsCollection = Backbone.Collection.extend
  #     model: Armor,
  #     url: '/' + path + '/' + id + '.json',
  #     parse: (response) ->
  #       returnJSON(response)
  #       return response

  #   armors = new ArmorsCollection()
  #   armors.fetch
  #     success: (response) ->
  #       return response

  # returnJSON = (response) ->
  #   console.log response

  # renderSelectedGear = ->
  #   RealWorldItemView = Backbone.View.extend
  #     tagName: 'li',
  #     template: null,

  #     initialize: ->
  #       # This is useful to bind(or delegate) the this keyword inside all the function objects to the view
  #       # Read more here: http://documentcloud.github.com/underscore/#bindAll
  #       _.bindAll(this)

  #       # later we will see complex template engines, but is the basic from underscore
  #       this.template = _.template('<span>Name: <strong><%= name %></strong> - <%= color %> </span>')
  #     ,
  #     render : ->
  #       $(this.el).html this.template( this.model.toJSON() )
  #       return this


  setup()

#   var tip = $(".db-tooltip");
#   $(function(){
#     $(".stats-row-container").tipTip({maxWidth: "auto",
#                             edgeOffset: 10,
#                             defaultPosition: "left",
#                             content: "      Click to show gear      ",
#                             delay: 1000});
#   });


# });
