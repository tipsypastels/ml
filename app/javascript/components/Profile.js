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
      <div className="Profile">
        <section className="profile-upper media">
          <div className="media-left">
            <Avatar url={this.props.avatarURL} size="128x128" />
          </div>

          <div className="media-content">
            <header className="level">
              <div className="level-left">
                <div>
                  <h1 className="title">
                    {this.buildUsernameBit()}
                  </h1>
                </div>

                {(() => {
                  if (this.props.followsYou) {
                    return (
                      <span className="follows-you tag is-primary">
                        Follows You
                      </span>
                    );
                  }
                })()}
              </div>

              <div className="level-right">
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
          </div>
        </section>

        <section className="profile-lower tile is-ancestor">
          <div className="tile is-parent">
            <div className="tile is-child notification is-primary">
              <div className="level">
                <div className="level-item has-text-centered">
                  <div>
                    <p className="title">
                      {this.props.topicCount}
                    </p>

                    <p className="heading">
                      {pluralize('Topic', this.props.topicCount)}
                    </p>
                  </div>
                </div>

                <div className="level-item has-text-centered">
                  <div>
                    <p className="title">
                      {this.props.postCount}
                    </p>

                    <p className="heading">
                      {pluralize('Post', this.props.postCount)}
                    </p>
                  </div>
                </div>

                <div className="level-item has-text-centered">
                  <div>
                    <p className="title">
                      {this.props.followCount}
                    </p>

                    <p className="heading">
                      Following
                    </p>
                  </div>
                </div>

                <div className="level-item has-text-centered">
                  <div>
                    <p className="title">
                      {this.state.followers}
                    </p>

                    <p className="heading">
                      {pluralize('Followers', this.state.followers)}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
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