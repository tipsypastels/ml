import React from "react"

import Post from './Post';
import PostReply from './PostReply';

class PostList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: this.props.posts,
    };
  }

  render () {
    const posts = this.state.posts.map(post => {
      return (
        <Post
          key={post.id}
          postID={post.id}
          profileURL={post.profileURL}
          avatarURL={post.avatarURL}
          userIsOP={post.userIsOP}
          username={post.username}
          content={post.content}
        />
      )
    });

    return (
      <div>
        <div className="PostList">
          {posts}
        </div>
        <div className="PostReply-container">
          <PostReply
            topicID={this.props.topicID}
            newPostEndpoint={this.props.newPostEndpoint}
            authenticity_token={this.props.authenticity_token}
            appendPost={this.appendPost}
          />
        </div>
      </div>
    );
  }

  appendPost = (post) => {
    this.setState({ posts: [...this.state.posts, post] });
  }
}

export default PostList
