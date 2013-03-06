impress().init()

class Sidebar
	constructor: ()->
		@hided = true
	click: ()->
		if @hided == true
			$(".side-bar").animate({right:"0px"})
			@fadeIn()
		else
			$(".side-bar").animate({right:"-350px"})
			@fadeOut()
		@hided = !@hided
	hide: ()->
		$(".side-bar").animate({right:"-350px"}) unless @hided
		@fadeOut()
		@hided=true
	show: ()->
		$(".side-bar").animate({right:"0px"}) if @hided == true
		@fadeIn()
		@hided = false
	fadeIn: ()->
		console.log 'fadeIn'
		$(".form").fadeIn(2500)
	fadeOut: ()->
		$(".form").fadeOut()

sidebar = new Sidebar()
$(".content-container").click ()->
	sidebar.show()

$(".border").click ()->
	sidebar.click()

$(".memories-container").click ()->
	sidebar.hide()
