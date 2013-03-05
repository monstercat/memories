impress().init()
$('.addMemory').click ()->
	console.log('add memory')
	$('.inner').prepend('<div class="step",data-x="0",data-z="-200000",data-rotate="90",data-scale="5">show haha</div>')
	impress().init()


sidebar = new Object()

$('.side-bar').click ()->
	console.log 'click'
	$(".side-bar").animate({right:"0px"})
