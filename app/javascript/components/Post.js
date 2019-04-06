import React from "react";

import Avatar from './Avatar';
import PostContent from './PostContent';

class Post extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editing: false,
      content: this.props.content,
    };
  }

  render () {
    return (
      <article className="Post media">
        <section className="media-left">
          <Avatar url={this.props.avatarURL} size="96x96" />

          {(() => {
             if (this.props.badgeContent) {
              return (
                <div className={`post-badge tag is-${this.props.topicColor}`}>
                  {this.props.badgeContent}
                </div>
              );
            }
          })()}
        </section>

        <section className="media-content">
          <PostContent 
            editing={this.state.editing}
            setContent={this.setContent}
            cancelEdits={this.cancelEdits}
            saveEdits={this.saveEdits}
            toggleEditing={this.toggleEditing}
            {...this.props}
          />
        </section>
      </article>
    );
  }

  setContent = (e) => {
    this.setState({ content: e.target.value });
  }

  toggleEditing = (e) => {
    if (!this.props.canEdit) {
      return;
    }
    
    this.setState({ editing: !this.state.editing });
  }

  saveEdits = (e) => {
    this.toggleEditing();

    if (this.state.content === this.props.content) {
      return;
    }

    this.props.submitEdits({ 
      postID: this.props.id, 
      content: this.state.content,
    });    
  }

  cancelEdits = (e) => {
    this.toggleEditing();
    this.setState({ content: this.props.content });
  }
}

export default Post;