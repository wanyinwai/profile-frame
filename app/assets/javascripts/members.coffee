# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@getMemberEmail = () ->
  console.log 'came in getemail'

  # get iframe url
  iframeURL = location.href

  formattedStr = iframeURL.split('?', 2)
  paramStr = formattedStr[1].split('&', 2)
  customer_email = paramStr[0].substring(paramStr[0].indexOf('=') + 1)
  customer_id = paramStr[1].substring(paramStr[1].indexOf('=') + 1)

  console.log 'iframeURL ' + iframeURL
  console.log 'formatted ' + formattedStr
  console.log 'paramStr ' + paramStr
  console.log 'email ' + customer_email
  console.log 'id ' + customer_id

  $.ajax
    url: 'http://profile-frame.herokuapp.com/memberinfo'
    type: 'POST'
    data: 'customer_email='+customer_email+'&customer_id='+customer_id
    headers: {
        'X-Transaction': 'POST memberinfo',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
    success: (data) ->
      console.log "Successfully passed data in ajax."
      console.log data['member_email_result']
      return
    error: (e) ->
      console.log "Ajax thrown an error."
      return


  console.log 'came after getemail'



$(document).ready(@getMemberEmail)
