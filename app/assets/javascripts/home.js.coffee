# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("span.boxplot").sparkline('html',
      type: 'box'
      height: '1.0em'
      lineColor: '#888'
      whiskerColor: '#333333'
      boxLineColor: '#333333'
      boxFillColor: '#F8F8F5'
      medianColor: '#e20000'
  )

  #navigation = responsiveNav("#nav");

  $('#browseToggle').click ->
      $('#search').slideToggle(100) if $("#search").is(":visible")
      $('#browseList').slideToggle(100)

  $('#searchToggle').click ->
      $('#browseList').slideToggle(100) if $("#browseList").is(":visible")
      $('#search').slideToggle(100)

  $('.arrow').click ->
    $(this).toggleClass('active')
    $(this).siblings().toggleClass('active') if $(this).siblings().hasClass('active')
