import React from "react";
import axios from "axios";

class PostReply extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      text: '',
    };
  }

  render () {
    return (
      <form 
        className={`PostReply message is-${this.props.topicColor}`}
        action={this.props.newPostEndpoint}
        onSubmit={this.submitPost}
      >
        <div className="message-header">
          Leave a reply
        </div>

        <div className="message-body">
          <textarea 
            className="textarea margin-bottom"
            name='post[content]'
            placeholder="Reply..."
            onChange={this.updateText}
            value={this.state.text}
          />
          <div className="flex">
            <div className="grows"></div>
            <input 
              type="submit" 
              value="Submit"
              className={`button is-${this.props.topicColor}`}
              disabled={!this.enableButton}
            />
          </div>
        </div>
      </form>
    );
  }

  get enableButton() {
    return this.state.text;
  }

  updateText = (e) => {
    this.props.sendTypingNotif();
    this.setState({ text: e.target.value });
  }

  submitPost = (e) => {
    axios({
      method: 'post',
      url: this.props.newPostEndpoint,
      data: {
        authenticity_token: this.props.authenticity_token,
        post: {
          topic_id: this.props.topicID,
          content: this.state.text,
        }
      }
    }).then(() => {
      // no longer need to append posts here,
      // we use ActionCable which also makes all the
      // threads live update
      this.setState({ text: '' });
    });

    e.preventDefault();
    return false;
  }
}

export default PostReply
