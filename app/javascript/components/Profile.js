import React from "react";
import axios from 'axios';
import pluralize from 'pluralize';

import FollowForm from './FollowForm';
import Avatar from './Avatar';

class Profile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      followers: this.props.initialFollowersCount,
    };
  }

  render () {
    return (
      <div className="Profile flex v-center">
        <div className="avatar-container">
          <Avatar url={this.props.avatarURL} size="128x128" />
        </div>

        <div className="main-content">
          <header className="flex v-center">
            <h1 className="title">
              {this.buildUsernameBit()}
            </h1>

            <div className="control-area">
              {(() => {
                if (!this.props.isSignedIn) {
                  return;
                }

                if (this.props.isSelf) {
                  return (
                    <a href={this.props.editProfilePath} className="button is-primary">
                      Edit Profile
                    </a>
                  );
                } else {
                  return (
                    <FollowForm
                      authenticity_token={this.props.authenticity_token}
                      initialFollowing={this.props.follow.initialFollowing}
                      followPath={this.props.follow.followPath}
                      unfollowPath={this.props.follow.unfollowPath}

                      setFollowers={this.setFollowers}
                      userID={this.props.userID}
                      currentUserID={this.props.currentUserID}
                    />
                  )
                }
              })()}
            </div>
          </header>

          <div className="level" >
            <div className="">
              <strong>
                {this.props.topicCount}
              </strong>

              &nbsp;

              <span>
                {pluralize('topic', this.props.topicCount)}
              </span>
            </div>

            <div className="level-item">
              <strong>
                {this.props.postCount}
              </strong>

              &nbsp;

              <span>
                {pluralize('post', this.props.postCount)}
              </span>
            </div>

            <div className="level-itemr">
              <strong>
                {this.props.followCount}
              </strong>

              &nbsp;

              <span>
                following
              </span>
            </div>

            <div className="level-item">
              <strong>
                {this.state.followers}  
              </strong>

              &nbsp;
              
              <span>
                {pluralize('follower', this.state.followers)}
              </span>
            </div>
          </div>
        </div>
      </div>
    );
  }

  buildUsernameBit() {
    if (this.props.name) {
      return (
        <React.Fragment>
          {this.props.name}

          <span className="text-light smaller margin-minor-left">
            {this.props.username}
          </span>
        </React.Fragment>
      );
    } else {
      return this.props.username;
    }
  }

  setFollowers = (followers) => {
    this.setState({ followers });
  }
}

export default Profile;