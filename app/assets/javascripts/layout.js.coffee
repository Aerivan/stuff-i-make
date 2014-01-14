ready = ->
	$('body').flowtype({minimum : 600 })

$(document).ready(ready)
$(document).on('page:load', ready)
