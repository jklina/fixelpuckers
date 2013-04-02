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
