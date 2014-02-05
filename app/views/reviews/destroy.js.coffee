Animation.animations.fadeOutAndRemove($("#<%= @review.selector %>"))
$('#review-count').text("<%= @submission.reviews.size %>")
$('#review-rating').text("<%= @submission.average_rating %>")
$("#review-form-holder").replaceWith('<%= j render partial: "reviews/review_form" %>')
