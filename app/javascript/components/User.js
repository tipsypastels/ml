import React from 'react';

import Avatar from './Avatar';
import FollowForm from './FollowForm';

class User extends React.Component {
  render () {
    return (
      <div className="User media media-centered">
        <div className="media-left">
          <Avatar url={this.props.avatarURL} />
        </div>

        <div className="media-content">

          <div className="title is-4">
            <a className="title is-4" href={this.props.profileURL}>
              {this.props.username}
            </a>
          
            {(() => {
              if (this.props.followsYou) {
                return (
                  <div className="tag is-primary follows-you">
                    Follows You
                  </div>
                );
              }
            })()}
          </div>
        </div>

        {(() => {
          if (this.props.canFollow) {
            return (
              <FollowForm
                initialFollowing={this.props.initialFollowing}
                setFollowers={this.setFollowers}
                userID={this.props.userID}
                currentUserID={this.props.currentUserID}
              />
            );
          } else if (this.props.isSelf) {
            return (
              <a className="button is-light" href={this.props.profileURL}>
                Profile
              </a>
            )
          }
        })()}
      </div>
    );
  }
}

export default User;
