import React from "react";

class Post extends React.Component {
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
          </div>
        </div>

        <div 
          className="post-body" 
          dangerouslySetInnerHTML={{ __html: this.props.content }}
        />
      </div>
    );
  }
}

export default Post;