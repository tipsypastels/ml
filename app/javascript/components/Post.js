import React from "react";

import Avatar from './Avatar';

class Post extends React.Component {
  render () {
    return (
      <div className="post" data-post-id={this.props.id}>
        <div className="post-header">
          <a href={this.props.profileURL} className="hidden flex v-center">
            <Avatar url={this.props.avatarURL} size="small" />

            <div className="blackblock rot-small">
              {this.props.username}
            </div>

            {(() => {
              if (this.props.userIsOP) {
                return (
                  <div className="blackblock rot-medium-reverse margin-minor-left small-caps" title="Original Poster">
                    op
                  </div>
                );
              }
            })()}
          </a>
        </div>

        <div className="post-body">
          {this.props.content}
        </div>
      </div>
    );
  }
}

export default Post