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
	disable:->
		$(".side-bar").css("right","-500px")

sidebar = new Sidebar()

# sidebar.disable()

$(".content-container").click ()->
	sidebar.show()
	return true

$(".border,.side-bar-icon").click ()->
	sidebar.click()

# $(".memories-container").click ()->
# 	sidebar.hide()

$(".arrow").mouseover ()->
	tip.show $('.arrow').get(0)

$(".arrow").mouseout ()->
	tip.hide()

$(".side-bar-icon").mouseover ()->
	tip.show $('.arrow').get(0)

$(".side-bar-icon").mouseout ()->
	tip.hide()

$(".memory-form").submit ()->
	console.log 'clicked submit'
	unless $('#form-email').val().length > 0
		alertify.error("Please enter you email")
		return false
	unless $('#form-name').val().length > 0
		alertify.error("Please enter you name")
		return false
	unless $('#form-memory').val().length > 0
		alertify.error("Please enter you memory")
		return false
	return true

