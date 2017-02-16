$(document).on('turbolinks:load', function() {
  var conversationId = $("[data-conversation]").data().conversation;
  var currentUser = $("[data-from]").data().from;
  App.messages = App.cable.subscriptions.create({channel: "MessagesChannel", conversation_id: conversationId}, {
    connected: function() {
      console.log("Connected to MessageChannel");
    },

    disconnected: function() {
      console.log("Disconnected from MessageChannel");
    },

    received: function(data) {
      if (data.message && data.from !== currentUser.id) {
        $(".conversation-view").append(data.message);
      }
    }
  });

  $('#message_body').on('keydown', function(event) {
    if (event.keyCode === 13 && $.trim(event.target.value)) {
      var conversationId = $("[data-conversation]").data().conversation;
      $('input').click();
      App.messages.send({
        message: event.target.value,
        conversation_id: conversationId
      });
      event.target.value = "";
      event.preventDefault();

      $(".conversation-view").append(
        "<div class='message'><div class='message-user'>"+currentUser.username+":</div>\
      <div class='message-content'>"+message+"</div></div>");
    }
  });
});
