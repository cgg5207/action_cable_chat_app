App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    alert("You have a new mention") if data.mention
    if (data.message && !data.message.blank?)
      $('#messages-table').append data.message
      scroll_bottom()

isOpenAt = false

$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()
  loadAtWho()
  $('textarea').autosize()



submit_message = () ->
  $('textarea#message_content').unbind "keydown"
  $('textarea#message_content').bind "keydown", "return", (el) ->
    if $(el.target).val().trim().length > 0 && !isOpenAt
      event.preventDefault();
      # $('input').click()
      $('#new_message').submit()
      event.target.value = ""
      event.preventDefault()
      event.stopPropagation()
      return false

scroll_bottom = () ->
  $('#messages').scrollTop($('#messages')[0].scrollHeight)

loadAtWho = ()->
  $('textarea#message_content').atwho(
    at: '@'
    callbacks: remoteFilter: (query, callback) ->
      if query != ''
        return $.getJSON('/users/names.json', { query: query }, (data) ->
          callback data
          return
        )
      return
  ).on('shown.atwho', (event, flag, query) ->
    isOpenAt = true
    return
  ).on 'hidden.atwho', (event, flag, query) ->
    isOpenAt = false
    return





