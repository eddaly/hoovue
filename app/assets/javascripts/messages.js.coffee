$ ->
  $(document).ready ->
    friends = for friend in window.friends
      id: friend.id
      value: friend.name
      label: friend.name

    if $("#message_recipient_name").length > 0
      $("#message_recipient_name").bind("keydown", (event) ->
        event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
      ).autocomplete
        minLength: 0
        source: friends
        select: (event, ui) ->
          $('#message_recipient_id').val ui.item.id