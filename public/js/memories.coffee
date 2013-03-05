impress().init()
$('.addMemory').click ()->
  console.log('add memory')
  $('.inner').prepend('<div class="step",data-x="0",data-z="-200000",data-rotate="90",data-scale="5">show haha</div>')
  impress().init()

class Sidebar
  constructor:
    @hide = true
  click: ->
    if @hide is on
      $(".side-bar").animate({right:"0px"})
