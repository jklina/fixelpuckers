# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  DataVis.boxPlot.drawBoxPlot($("span.thumb--boxplot"))
  DataVis.scoreDisplay.drawReviewArcVis($(".rating-vis"))

  #navigation = responsiveNav("#nav");

  $('#browseToggle').click ->
      $('#search').slideToggle(100) if $("#search").is(":visible")
      $('#browseList').slideToggle(100)

  $('#searchToggle').click ->
      $('#browseList').slideToggle(100) if $("#browseList").is(":visible")
      $('#search').slideToggle(100)
