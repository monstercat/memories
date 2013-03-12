impress().init()

Tip = require 'component-tip'
arrowTip = new Tip('Write your Memory').position('north')
cookie = require 'component-cookie'

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

unless cookie('memory-submitted')
	$(".side-bar").show()

$(".content-container").click ()->
	sidebar.show()
	return true

$(".border,.side-bar-icon").click ()->
	sidebar.click()

# $(".memories-container").click ()->
# 	sidebar.hide()

#=----------------------------------------------------------------------------=#
# tips
#=----------------------------------------------------------------------------=#
$arrow = $(".arrow")
$icon  = $(".side-bar-icon")

$arrow.mouseover ->
  arrowTip.show $arrow.get(0)
$arrow.mouseout ->
  arrowTip.hide()

$icon.mouseover ()->
  arrowTip.show $arrow.get(0)
$icon.mouseout ()->
  arrowTip.hide()

do ->
  $tag = $(".secret")
  redeemed = $tag.hasClass("allfound")

  msg = if redeemed then "All album codes have been redeemed!" else "There have been rumors of Aftermath album codes hidden within the memory stream..."

  tip = new Tip(msg)
    .position("east")
  $tag.mouseover ->
    $tag.fadeTo('slow', 1)
    tip.show $tag.get(0)
  $tag.mouseout ->
    $tag.fadeTo('slow', 0.2)
    tip.hide()

openInTab = (url) ->
  win = window.open(url, '_blank')
  win.focus()

$("#redeem").click ->
  $redeem = $(this)
  code = $redeem.data("code")
  $.get "/redeem/#{ code }", (data)->
    if data.success
      window.location = "http://music.monstercat.com/yum?code=c#{ code }"
    else
      alertify.error "Sorry, this code has already been redeemed :("

$(".memory-form").submit ()->
	email = $('#form-email').val()
	unless email.length > 0
		alertify.error("Please enter you email")
		return false
	re =  /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
	unless re.test(email)
		alertify.error("incorrect email format")
		return false
	unless $('#form-name').val().length > 0
		alertify.error("Please enter you name")
		return false
	unless $('#form-memory').val().length > 0
		alertify.error("Please enter you memory")
		return false
	unless $('#form-memory').val().length <= 725
		alertify.error("Please enter memory that shorter than 725 characters")
		return false
	return true

