# JQuery plugin for hiding an element offscreen unless the mouse is
# near the corresponding corner.
( ( $ ) ->

	move_out = ($obj, corner, duration='fast') ->
		switch corner
			when 'top-left'
				pos = {top: -$obj.outerWidth(), left: -$obj.outerWidth()}
			when 'top-right'
				pos = {top: -$obj.outerWidth(), right: -$obj.outerWidth()}
			when 'bottom-left'
				pos = {bottom: -$obj.outerWidth(), left: -$obj.outerWidth()}
			when 'bottom-right'
				pos = {bottom: -$obj.outerWidth(), right: -$obj.outerWidth()}

		$obj.animate(pos, duration)

	move_in = ($obj, corner, duration='fast') ->
		switch corner
			when 'top-left'
				pos = {top: 0, left: 0}
			when 'top-right'
				pos = {top: 0, right: 0}
			when 'bottom-left'
				pos = {bottom: 0, left: 0}
			when 'bottom-right'
				pos = {bottom: 0, right: 0}

		$obj.animate(pos, duration)


	$.fn.active_corner = ( options ) ->
		$corner_object = this

		# Default options.
		settings = $.extend(
			corner: 'top-left' # other options: bottom-left, top-right, bottom-right
			vertical_distance: 100
			horizontal_distance: 200
			animate: "false" # TODO: make it possible to animate.
		, options )

		this.css( position: 'fixed' )

		move_out(this, settings.corner, 0)

		$('body').mousemove( (event) ->
			switch settings.corner
				when 'top-left'
					dy = event.clientY
					dx = event.clientX
				when 'top-right'
					dy = event.clientY
					dx = $(window).width() - event.clientX
				when 'bottom-left'
					dy = $(window).height() - event.clientY
					dx = event.clientX
				when 'bottom-right'
					dy = $(window).height() - event.clientY
					dx = $(window).width() - event.clientX

			if !$corner_object.is(':animated')
				if dy <= $corner_object.outerHeight() && dx <= $corner_object.outerWidth()
					move_in($corner_object, settings.corner)
				else
					move_out($corner_object, settings.corner)
		)

		$('body').mousemove()

		return this
)( jQuery )

# Turn on active corner for the #actions div of the layout.
activate_on_active_corner = ->
	$('#actions').active_corner({corner: 'bottom-left'})

$(document).ready(activate_on_active_corner)
$(document).on('page:load', activate_on_active_corner)
