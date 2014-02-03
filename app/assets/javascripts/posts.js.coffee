# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init_expanding_textarea = ->
  $(".expanding").expandingTextarea();

  editor = ace.edit("editor")
  editor.setTheme("ace/theme/monokai")
  embedded_editor = ace.edit("embedded_ace_code")
  embedded_editor.container.style.opacity = ""
  embedded_editor.session.setMode("ace/mode/html")
  embedded_editor.setAutoScrollEditorIntoView(true)
  embedded_editor.setOption("maxLines", 40)

  # init infinite scrolling
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text('Fetching more products...')
        $.getScript(url)
    $(window).scroll()

$(document).ready(init_expanding_textarea)
$(document).on('page:load', init_expanding_textarea)
