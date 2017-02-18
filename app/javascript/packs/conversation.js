
import Rx from 'rxjs/Rx';

const config = window._global || {};
const App = window.App;
const log = window.console.log.bind(window.console);

// class Channel ....
// 应该把 channel 拿出来作为一个 class，用来维护 cable 的
// channel 和 conversation id 等。

class Conversation {
  constructor() {
    this._typing = null;
    this._target = null;
    this._view = null;
    this._channel = null;
  }

  init() {
    this._target = $('#message_body');
    this._typing = this.getTyping();
    this._view = $(".conversation-view");
    this._channel = this.getChannel(
      config.channel,
      config.conversationId);
    this._listen();
  }

  received(data) {
    log('received message');
    this.appendMessage(data.message);
    this.scrollBottom();
  }

  appendMessage(message) {
    var classSuffix = message.user_id === config.currentUserId ? 'self' : 'friend';
    var appended = $('<div/>').addClass('message message-'+classSuffix);

    $('<div/>').addClass('message-user')
    .append($('<span/>').addClass('realtime-status'))
    .append($('<span>'+message.username+'</span>').addClass('username'))
    .append($('<time>'+message.created_at+'</time>').addClass('time'))
    .appendTo(appended);

    $('<div/>').addClass('message-bubble')
    .append($('<div>'+message.body+'</div>').addClass('message-content'))
    .appendTo(appended);

    this._view.append(appended);
  }

  getChannel(channel, cid) {
    let self = this;

    return App.cable.subscriptions.create({
      channel,
      conversation_id: cid,
    }, {
      connected() {
        log(`Connected to ${channel}`);
        // self is online
        $('.conversation-view').addClass('self-online');
      },
      disconnected() {
        log(`Disconnected from ${channel}`);
        // self is offline
        $('.conversation-view')
          .removeClass('self-online')
          .addClass('self-offline');
      },
      received(data) {
        if (data.message) {
          self.received({
            channel,
            message: data.message
          });
        }
      },
      appear() {
        log('apear');
      },
      away() {
        log('away');
      }
    })
  }

  // send text
  send(text) {
    log('message sent');
    return this._channel.send({
      message: text,
      conversation_id: config.conversationId,
    });
  }

  // clear textarea
  clear() {
    this._target.val('');
  }

  getTyping() {
    if (this._typing) {
      return this._typing;
    }

    this._typing = Rx.Observable.fromEvent(
      this._target,
      'keydown');
    return this._typing;
  }

  _listen() {
    this.getTyping()
      // filter out text length great than 0.
      .filter(event => event.target.value.length > 0)
      // filter out enter key event.
      .filter(event => event.keyCode === 13)
      // prevent default
      .do(event => event.preventDefault())
      // get out the text value.
      .map(event => event.target.value)
      .subscribe((val) => {
        // now we receive a valid value.
        // send text
        this.send(val);
        // clear textarea
        this.clear();
      });
  }

  scrollBottom() {
    var view = document.querySelector('.conversation-view');
      view.scrollTop = view.scrollHeight;
  }
}

$(document).ready(() => {
  const conversation = new Conversation();
  conversation.init();
  conversation.scrollBottom();
});
