# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



@getMemberEmail = ()->

  # frameSrc = window.frameElement.src
  # console.log(frameSrc)

  iframeSrc = $('#profile_frame').attr('src')
  console.log(iframeSrc)


$(document).ready(@getMemberEmail)
