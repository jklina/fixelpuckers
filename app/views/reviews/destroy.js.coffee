# $("#<%= @review.selector %>").oriDomi('foldUp', 20, (event, instance)->
#   $(instance.el).remove()
# )

# folded = new OriDomi("#<%= @review.selector %>")
# folded.foldUp(() ->
#   console.log(folded.el)
#   $(folded.el).remove()
# )
# 
Animation.animations.fadeOutAndRemove($("#<%= @review.selector %>"))
$('#review-count').text("<%= @submission.reviews.size %>")
$('#review-rating').text("<%= @submission.average_rating %>")
$("#review-form-holder").replaceWith('<%= j render partial: "reviews/review_form" %>')
