import React, { Component } from 'react';
import axios from 'axios';

class Lock extends Component {
  constructor(props) {
    super(props);
    this.state = {
      reason: '',
    }
  }
  
  render() {
    return (
      <form onSubmit={this.submit}>
        <label className="label" htmlFor="lock-reason">
          Lock Reason
        </label>

        <div className="field has-addons">
          <div className="control is-expanded has-icons-left">
            <span className="icon is-small is-left">
              <i className="fas fa-lock" />
            </span>

            <input
              id="lock-reason"
              className="input"
              type="text"
              value={this.state.reason}
              onChange={(e) => this.setState({ reason: e.target.value })}
              />
          </div>

          <div className="control">
            <input
              autoFocus
              className="button is-primary"
              type="submit"
              disabled={!this.state.reason}
              value="Lock"
            />
          </div>

          <div className="control">
            <p className="button is-light" onClick={this.props.clearAction}>
              <span>
                Back
              </span>
            </p>
          </div>
        </div>
      </form>
     );
  }

  submit = (e) => {
    e.preventDefault();

    axios({
      method: 'post',
      url: this.props.lockEndpoint,
      data: {
        topic_id: this.props.topicID,
        reason: this.state.reason,
        authenticity_token: this.props.authenticity_token,
      }
    }).then(({ data }) => {
      this.props.setLocked(data.locked);
      this.props.clearAction();
    });
  }
}

export default Lock;