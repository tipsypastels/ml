import React from "react";

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
      <div className="post" data-post-id={this.props.id}>
        <div className="post-header">
          <div className="flex v-center">
            <a href={this.props.profileURL} className="hidden flex v-center">
              <img src={this.props.avatarURL} className="avatar avatar-small" />

              <div className="blackblock rot-small">
                {this.props.username}
              </div>

            </a>

            {(() => {
              if (this.props.userIsOP) {
                return (
                  <div className="blackblock rot-medium-reverse margin-minor-left small-caps" title="Original Poster">
                    op
                  </div>
                );
              }
            })()}

            <div className="grows">
            </div>

            {(() => {
              if (this.state.editing) {
                return (
                  <button 
                    className="blackblock rot-small-reverse"
                    onClick={this.saveEdits}
                  >
                    Save
                  </button>
                );
              } else if (this.props.canEdit) {
                return (
                  <button 
                    className="blackblock rot-small-reverse"
                    onClick={this.toggleEditing}
                  >
                    Edit
                  </button>
                );
              }
            })()}
          </div>
        </div>

        {(() => {
          if (this.state.editing) {
            return (
              <textarea
                onChange={this.setContent}
                defaultValue={this.props.content}
              />
            );
          } else {
            return (
              <div
                className="post-body"
                dangerouslySetInnerHTML={{ __html: this.props.markdown_content }}
              />
            );
          }
        })()}
      </div>
    );
  }

  setContent = (e) => {
    this.setState({ content: e.target.value });
  }

  toggleEditing = (e) => {
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
}

export default Post;