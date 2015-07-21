# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



@getMemberEmail = ()->
  console.log "came in getemail"

  # frameSrc = window.frameElement.src
  # console.log(frameSrc)
  x = document.getElementsByTagName('iframe').getAttribute('memberid')
  console.log x

  iframeURL = location.href
  console.log iframeURL

  iframeSrc = $('#profile_frame').attr('src')
  console.log iframeSrc

  console.log "came after getemail"

$(document).ready(@getMemberEmail)
