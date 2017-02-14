App.message = App.cable.subscriptions.create("MessageChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    if (data.body !== '') {
      $('#messages-table').append(data.rendered_message)
    }
  }
});

var register_submit_message = function() {
  $('#message_body').on('keydown', function(event) {
    if (event.keyCode === 13) {
      $('input').click();
      event.target.value = "";
      event.preventDefault();
    }
  });
};

$(document).on('turbolinks:load', function() {
  register_submit_message();
});
