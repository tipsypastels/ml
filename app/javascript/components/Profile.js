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

  /*
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
        */

  render () {
    return (
      <div className="Profile">
        <section className="profile-upper media">
          <div className="media-left">
            <Avatar url={this.props.avatarURL} size="128x128" />
          </div>

          <div className="media-content">
            <header className="level">
              <h1 className="level-left title">
                {this.buildUsernameBit()}
              </h1>

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
                    <p class="title">
                      {this.props.topicCount}
                    </p>

                    <p class="heading">
                      {pluralize('Topic', this.props.topicCount)}
                    </p>
                  </div>
                </div>

                <div className="level-item has-text-centered">
                  <div>
                    <p class="title">
                      {this.props.postCount}
                    </p>

                    <p class="heading">
                      {pluralize('Post', this.props.postCount)}
                    </p>
                  </div>
                </div>

                <div className="level-item has-text-centered">
                  <div>
                    <p class="title">
                      {this.props.followCount}
                    </p>

                    <p class="heading">
                      {pluralize('Following', this.props.followCount)}
                    </p>
                  </div>
                </div>

                <div className="level-item has-text-centered">
                  <div>
                    <p class="title">
                      {this.state.followers}
                    </p>

                    <p class="heading">
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