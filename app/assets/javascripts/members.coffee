# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@passMemberEmail = () ->
  console.log 'came in passemail'



@getMemberEmail = () ->
  console.log 'came in getemail'

  #customer_email = parent.document.getElementById('profile_frame').getAttribute('customer_email')
  #customer_id = parent.document.getElementById('profile_frame').getAttribute('customer_id')

  # console.log customer_email
  # console.log customer_id

  iframeURL = location.href

  formattedStr = iframeURL.split('?', 2)
  paramStr = formattedStr[1].split('&', 2)
  customer_email = paramStr[0].substring(paramStr[0].indexOf('=') + 1)
  customer_id = paramStr[1].substring(paramStr[1].indexOf('=') + 1)

  console.log 'iframeURL ' + iframeURL
  console.log 'formatted ' + formattedStr
  console.log 'paramStr ' + paramStr
  console.log 'email ' + customer_email
  console.log 'id' + customer_id

  @passMemberEmail

  console.log 'came after getemail'



$(document).ready(@getMemberEmail)
