import React, { Component } from 'react';
import axios from 'axios';

import CheckboxButton from '../CheckboxButton';

export default class Unlock extends Component {
  constructor(props) {
    super(props)
    this.state = {
      update: true,       
    };
  }
  
  render() {
    return (
      <form onSubmit={this.submit}>
        <label className="label">
          Unlock
        </label>

        <div className="field has-addons">
          <div className="control is-expanded">
            <CheckboxButton
              className="input"
              active={this.state.update}
              onChange={(e) => this.setState({ update: e.target.checked })}
              passiveClass="light"
            >
              Display Update
            </CheckboxButton>
          </div>

          <div className="control">
            <input
              autoFocus
              className="button is-primary"
              type="submit"
              value="Unlock"
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
    )
  }

  submit = (e) => {
    e.preventDefault();

    axios({
      method: 'delete',
      url: this.props.unlockEndpoint,
      data: {
        topic_id: this.props.topicID,
        update: this.state.update,
        authenticity_token: this.props.authenticity_token,
      }
    }).then(({ data }) => {
      this.props.setLocked(data.locked);
      this.props.clearAction();
    });
  }
}
