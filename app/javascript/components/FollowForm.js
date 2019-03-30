import React from "react";
import axios from 'axios';

class FollowForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      following: this.props.initialFollowing,
    }
  }

  render () {
    const { following } = this.state;

    const followButton = 
      <button
        className="primary"
        onClick={this.followAPI}
      >
        Follow
      </button>;

      const unfollowButton = 
      <button
        onClick={this.unfollowAPI}
      >
        Unfollow
      </button>;
    return (
      <div className="follow">
        {following ? unfollowButton  : followButton}
      </div>
    );
  }

  followAPI = () => {
    this.sendRequest('post', this.props.followPath)
      .then(() => {
        this.setState({ following: true });
        this.props.increaseFollowers();
      });
  }

  unfollowAPI = () => {
    this.sendRequest('delete', this.props.unfollowPath)
      .then(() => {
        this.setState({ following: false });
        this.props.decreaseFollowers();
      });
  }

  sendRequest(method, url) {
    const { authenticity_token } = this.props;
    return axios({
      method,
      url,
      data: { authenticity_token },
    });
  }

}

export default FollowForm;