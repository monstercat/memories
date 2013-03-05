impress().init()

class Sidebar 
	constructor: ()->
		@hide = true
	click: ()->
		console.log @hide
		if @hide == true 
			$(".side-bar").animate({right:"0px"})
		else 
			$(".side-bar").animate({right:"-500px"})
		@hide = !@hide

sidebar = new Sidebar()
$(".side-bar").click ()->
	sidebar.click()
