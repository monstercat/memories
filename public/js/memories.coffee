impress().init()

Tip = require 'component-tip'
tip = new Tip('Write your Memory').position('north')

class Sidebar
	constructor: ()->
		@hided = true
	click: ()->
		if @hided == true
			$(".side-bar").animate({right:"0px"})
			@fadeIn()
		else
			$(".side-bar").animate({right:"-300px"})
			@fadeOut()
		@hided = !@hided
	hide: ()->
		$(".side-bar").animate({right:"-300px"}) unless @hided
		@fadeOut()
		@hided=true
	show: ()->
		$(".side-bar").animate({right:"0px"}) if @hided == true
		@fadeIn()
		@hided = false
	fadeIn: ()->
		$(".form").fadeIn(2500)
		impress().disable()
	fadeOut: ->
		$(".form").fadeOut()
		impress().enable()

sidebar = new Sidebar()
$(".content-container").click ()->
	sidebar.show()

$(".border").click ()->
	sidebar.click()

$(".memories-container").click ()->
	sidebar.hide()

$(".arrow").mouseover ()->
	# tip.show(100, 100)
	tip.show $('.arrow').get(0)

$(".arrow").mouseout ()->
	tip.hide()
