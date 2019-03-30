import React from "react";
import axios from 'axios';
import pluralize from 'pluralize';

import FollowForm from './FollowForm';

class Profile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      followers: this.props.initialFollowersCount,
      fieldsToSave: {},
      name: this.props.name,
    };
  }

  render () {
    return (
      <div className="Profile flex v-center">
        <div className="avatar-container">
          <img className="avatar avatar-huge" src={this.props.avatarURL}/>
        </div>

        <div className="main-content grows">
          <header className="flex v-center">
            <h1 className="username grows flex v-center">
              {this.buildUsernameBit()}
            </h1>

            <div className="control-area">
              {(() => {
                if (!this.props.isSignedIn) {
                  return;
                }

                if (this.props.isSelf) {
                  return (
                    <a href={this.props.editProfilePath} className="btn">
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

                      increaseFollowers={this.increaseFollowers}
                      decreaseFollowers={this.decreaseFollowers}
                    />
                  )
                }
              })()}
            </div>
          </header>

          <div className="stats flex">
            <div className="topics margin-minor">
              <strong>
                {this.props.topicCount}
              </strong>

              {pluralize('topic', this.props.topicCount)}
            </div>

            <div className="posts margin-minor">
              <strong>
                {this.props.postCount}
              </strong>

              {pluralize('post', this.props.postCount)}
            </div>

            <div className="follows margin-minor">
              <strong>
                {this.props.followCount}
              </strong>

              following
            </div>

            <div className="followers margin-minor">
              <strong>
                {this.state.followers}  
              </strong>
              
              {pluralize('follower', this.state.followers)}
            </div>
          </div>
        </div>
      </div>
    );
  }

  buildUsernameBit() {
    if (this.state.name) {
      return (
        <React.Fragment>
          {this.state.name}

          <span className="text-light smaller margin-minor-left">
            {this.props.username}
          </span>
        </React.Fragment>
      );
    } else {
      return this.props.username;
    }
  }

  markForSave = (newSave) => {
    this.setState({ 
      fieldsToSave: Object.assign(
        {}, 
        this.state.fieldsToSave, 
        newSave,
      ) 
    });
  }

  increaseFollowers = () => {
    this.setState({ followers: this.state.followers + 1 });
  }

  decreaseFollowers = () => {
    this.setState({ followers: this.state.followers - 1 });
  }  
}

export default Profile
