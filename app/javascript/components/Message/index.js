
import React from 'react';

export default class Message extends React.Component {

  isSelf() {
    let { user_id } = this.props.message;
    return this.props.isSelf(user_id);
  }

  render() {
    let classSuffix = this.isSelf() ? 'self' : 'friend';
    let { username, body, created_at } = this.props.message;

    return (
      <div className={`message message-${classSuffix}`}>
        <div className="message-user">
          <span className="realtime-status"></span>
          <span className="username">{ username }</span>
          <span className="time">{ created_at }</span>
        </div>
        <div className="message-bubble">
          <div className="message-content">{ body }</div>
        </div>
      </div>
      )
  }
}

Message.defaultProps = {
  message: {},
  isSelf: () => true,
}

Message.propTypes = {
  message: React.PropTypes.object,
  isSelf: React.PropTypes.func,
}
