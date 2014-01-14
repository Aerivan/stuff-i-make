ready = ->
	if window.location.pathname != '/' || $('.alert').length > 0 # TODO: Change to use root_url instead.
		window.scrollTo(pageXOffset, $('header').outerHeight())

	if window.location.pathname != '/'
		$('#headlines').addClass('header-link')
		$('#headlines').click(() -> Turbolinks.visit('/'))

$(document).ready(ready)
$(document).on('page:load', ready)
