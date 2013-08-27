$ ->
  $(document).ready ->

    if $("#message_recipient_name").length > 0

      friends = for friend in window.friends
        uid: friend.uid
        value: friend.name
        label: friend.name

      $("#message_recipient_name").bind("keydown", (event) ->
        event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
      ).autocomplete
        minLength: 0
        source: friends
        select: (event, ui) ->
          $('#message_recipient_uid').val ui.item.uid