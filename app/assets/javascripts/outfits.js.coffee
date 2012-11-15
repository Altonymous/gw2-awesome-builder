# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Outfits =
  setup: (@container) ->
    Outfits.setupTable()
    Outfits.setupSliders()
    Outfits.jsonTest()

  setupTable: ->
    $('#stats').fauxtable
      items: '>:not(.nosort)',
      placeholder: 'placeholder',
      helper: '.stats-slider',
      stop: (e, ui) ->
        Outfits.highlightTableColumn(ui.item.index()+1)
      change: (e, ui) ->
        Outfits.handleTableEndCorners()
    $(".stats-row").click -> Outfits.handleOutfitClick($(this))

  setupSliders: ->
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

  highlightTableColumn: (i) ->
    setTimeout ->
      $(".stats-row .stats-item:nth-child("+i+")").effect("highlight", 400)
      $(".stats-header .stats-slider:nth-child("+i+")").effect("highlight")
      $(".fix-me").removeClass('fix-me')
    , 100

  handleTableEndCorners: ->
    lastItem = $(".stats-header .stats-slider:last-child")
    prevItem = $(".ui-sortable-helper").prev()

    if lastItem.hasClass("ui-sortable-helper") &&
    lastItem.prev().hasClass('stats-slider')
      prevItem.addClass('fix-me')
    else
      $(".fix-me").removeClass('fix-me')

  handleOutfitClick: (item) ->
    # this is useless if i dont have a full data set
    console.log Outfits.getArmor @armors.toJSON(), "id", item.data("boots-id")

  getArmor: (obj, key, val) ->
    $.grep obj, (item) ->
      console.log item.armor[key]
      return item.armor.key == val # I dont know how to get key to eval


  jsonTest: ->
    Armor = Backbone.Model.extend()
    ArmorsCollection = Backbone.Collection.extend
      model: Armor,
      url: '/armors.json',
      poop: ->
        return this.filter (armor) ->
          return armor

    @armors = new ArmorsCollection()
    @armors.fetch
      success: (collection, response) ->
        console.log response

$ Outfits.setup

#   var tip = $(".db-tooltip");
#   $(function(){
#     $(".stats-row-container").tipTip({maxWidth: "auto",
#                             edgeOffset: 10,
#                             defaultPosition: "left",
#                             content: "      Click to show gear      ",
#                             delay: 1000});
#   });


# });
