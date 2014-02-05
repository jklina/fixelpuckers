window.Animation = {}

Animation.animations = (->
  animationEndings = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'

  fadeOutAndRemove: (element) ->
    element.one(animationEndings, ()->
      console.log(element)
      element.remove()
    )
    element.addClass('animated fadeOutUp')
)()

