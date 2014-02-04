window.DataVis = {}

DataVis.scoreDisplay = (->
  setArc = (paper) ->
    paper.customAttributes.arc = (xloc, yloc, value, total, R) ->
      alpha = 360 / total * value
      a = (90 - alpha) * Math.PI / 180
      x = xloc + R * Math.cos(a)
      y = yloc - R * Math.sin(a)
      path = undefined
      if total is value
        path = [["M", xloc, yloc - R], ["A", R, R, 0, 1, 1, xloc - 0.01, yloc - R]]
      else
        path = [["M", xloc, yloc - R], ["A", R, R, 0, +(alpha > 180), 1, x, y]]

      path: path

  drawFullArc = (paper) ->
    paper.path().attr(
      stroke: "#aaa"
      "stroke-width": 1
      arc: [18, 18, 100, 100, 17]
    )

  drawRatingArc = (paper) ->
    paper.path().attr(
      stroke: "#333"
      "stroke-width": 2
      arc: [18, 18, 0, 100, 17]
    )

  drawReviewArc = (canvas, rating) ->
    paper = Raphael(canvas, 36, 36)
    setArc(paper)
    drawFullArc(paper)
    ratingArc = drawRatingArc(paper)

    ratingArc.animate
      arc: [18, 18, rating, 100, 17]
    , 2500, "bounce"

  extractRatingFromElement = (element) ->
    $(element).children('.rating').first().text()

  drawReviewArcVis: (ratings) ->
    ratings.each((index, element) ->
      drawReviewArc(element, extractRatingFromElement(element))
    )
)()

DataVis.boxPlot = (->
  drawBoxPlot: (container) ->
    container.sparkline('html',
      type: 'box'
      height: '1.0em'
      lineColor: '#888'
      whiskerColor: '#333333'
      boxLineColor: '#333333'
      boxFillColor: '#F8F8F5'
      medianColor: '#e20000'
    )
)()
