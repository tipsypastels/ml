import React from "react";
import axios from 'axios';

class FollowForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      following: this.props.initialFollowing,
    }
  }

  componentDidMount() {
    let component = this;

    this.channel = App.cable.subscriptions.create(
      {
        channel: 'UserChannel',
        user_id: this.props.userID,
      }, 

      {
        received({ followers }) {
          component.setFollowingIfIn(followers);
          component.props.setFollowers(followers.length);
        },

        sendFollow({ from, to }) {
          this.perform('send_follow', { from, to });
        },

        sendUnfollow({ from, to }) {
          this.perform('send_unfollow', { from, to });
        }
      },
    );
  }

  componentWillUnmount() {
    if (this.channel) {
      this.channel.unsubscribe();
    }
  }

  render () {
    const { following } = this.state;

    const followButton = (
      <button
        className="primary"
        onClick={this.followAPI}
      >
        Follow
      </button>
    );

    const unfollowButton = (
      <button
        onClick={this.unfollowAPI}
      >
        Unfollow
      </button>
    );
    
    return (
      <div className="follow">
        {following ? unfollowButton  : followButton}
      </div>
    );
  }

  setFollowingIfIn = (followers) => {
    this.setState({ 
      following: followers.includes(this.props.currentUserID) 
    });
  }

  followAPI = () => {
    this.channel.sendFollow({
      from: this.props.currentUserID,
      to: this.props.userID,
    });
  }

  unfollowAPI = () => {
    this.channel.sendUnfollow({
      from: this.props.currentUserID,
      to: this.props.userID,
    });
  }
}

export default FollowForm;