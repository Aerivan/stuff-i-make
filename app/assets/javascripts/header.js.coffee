ready = ->
	if window.location.pathname != '/' # TODO: Change to use root_url instead.
		window.scrollTo(pageXOffset, $('header').height())

$(document).ready(ready)
$(document).on('page:load', ready)
