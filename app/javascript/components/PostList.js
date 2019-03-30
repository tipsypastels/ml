import React from "react"

import Post from './Post';

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
      <div className="PostList">
        {posts}
      </div>
    );
  }
}

export default PostList
