ready = ->
	if window.location.pathname != '/' || $('.alert').length > 0 # TODO: Change to use root_url instead.
		window.scrollTo(pageXOffset, $('header').height())

		$('#headlines').addClass('header-link')
		$('#headlines').click(() -> window.location = '/')

$(document).ready(ready)
$(document).on('page:load', ready)
