import React from "react";
import unique from 'array-unique';

import Post from './Post';
import PostReply from './PostReply';

class PostList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: this.props.posts,
      typing: false,
      typingUsers: [],
    };
  }

  componentDidMount() {
    const component = this;

    this.channel = App.cable.subscriptions.create(
      {
        channel: 'TopicChannel',
        topic_id: this.props.topicID,
      }, 

      {
        received(data) {
          switch(data.type) {
            case 'post':
              component.appendPost(data.post);
              component.removeTypingUser(data.post.username);
              break;

            case 'started_typing':
              component.addTypingUser(data.username);
              break;
          
            case 'stopped_typing':
              component.removeTypingUser(data.username);
              break;
          }
        },

        sendTyping(username) {
          this.perform('send_typing', { username });
        },

        sendStoppedTyping(username) {
          this.perform('send_stopped_typing', { username });
        },
      },
    );
  }

  render () {
    const posts = this.state.posts.map(post => {
      return (
        <Post
          key={post.id}
          {...post}
        />
      )
    });

    const typingNotif = this.buildTypingNotif();

    return (
      <div>
        <div className="PostList">
          {posts}
        </div>

        {(() => {
          if (typingNotif) {
            return (
              <div className="typing-notif blackblock rot-small">
                {typingNotif}
              </div>
            );
          }
        })()}

        {(() => {
          if (this.props.canPost) {
            return (
              <div className="PostReply-container">
                <PostReply
                  topicID={this.props.topicID}
                  newPostEndpoint={this.props.newPostEndpoint}
                  authenticity_token={this.props.authenticity_token}
                  appendPost={this.appendPost}
                  sendTypingNotif={this.sendTypingNotif}
                />
              </div>
            );
          }
        })()}
      </div>
    );
  }

  TYPING_NOTIF_EXPIRY_MILLISECONDS = 30000;

  sendTypingNotif = () => {
    const { currentUsername } = this.props;

    if (this.state.typing) {
      return;
    }

    this.setState({ typing: true });
    this.channel.sendTyping(currentUsername);

    setTimeout(() => {
      this.setState({ typing: false });
      this.channel.sendStoppedTyping(currentUsername);
    }, this.TYPING_NOTIF_EXPIRY_MILLISECONDS);
  }

  addTypingUser(username) {
    const typingUsers = unique([
      ...this.state.typingUsers, username
    ]);

    this.setState({ typingUsers })
  }

  removeTypingUser(username) {
    const idx = this.state.typingUsers.indexOf(username);
    if (idx === -1) {
      return;
    }

    const typingUsers = this.state.typingUsers
      .filter(name => name !== username);

    this.setState({ typingUsers });
  }

  buildTypingNotif() {
    const notif = new TypingNotif({ 
      list: this.state.typingUsers,
      exclude: this.props.currentUsername,
    });

    return notif.build();
  }

  appendPost = (post) => {
    this.setState({ posts: [...this.state.posts, post] });
  }
}

export default PostList;
