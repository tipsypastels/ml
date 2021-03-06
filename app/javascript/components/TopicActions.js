import React from "react"
import axios from 'axios';
import { If, Then, Else } from 'react-if';

import Lock from './topicActions/Lock';
import Unlock from './topicActions/Unlock';
import Destroy from './topicActions/Destroy';

class TopicActions extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      action: null,
      isLocked: this.props.isLocked,
    }
  }

  render() {
    switch(this.state.action) {
      case 'lock': {
        return (
          <Lock
            clearAction={this.clearAction}
            setLocked={this.setLocked}
            topicID={this.props.topicID}
            authenticity_token={this.props.authenticity_token}
            {...this.props.lock}
          />
        );
      }

      case 'unlock': {
        return (
          <Unlock
            clearAction={this.clearAction}
            setLocked={this.setLocked}
            topicID={this.props.topicID}
            authenticity_token={this.props.authenticity_token}
            {...this.props.lock}
          />
        )
      }

      case 'destroy': {
        return (
          <Destroy
            clearAction={this.clearAction}
            {...this.props.destroy}
          />
        )
      }

      default: {
        return this.mainMenu();
      }
    }
  }

  mainMenu () {
    const userActions = (
      <React.Fragment>
        <p className="menu-label">
          User Actions
        </p>

        <ul className="menu-list">
          <li>
            <a data-modal="close" onClick={this.nudge}>
              <span className="icon is-small">
                <i className="fa fa-heartbeat" />
              </span>

              {' '}

              <span>
                Nudge
              </span>
            </a>
          </li>

          <li>
            <a>
              <span className="icon is-small">
                <i className="fa fa-heart" />
              </span>

              {' '}

              <span>
                Favorite
              </span>
            </a>
          </li>

          <li>
            <a>
              <span className="icon is-small">
                <i className="fa fa-flag" />
              </span>

              {' '}

              <span>
                Report
              </span>
            </a>
          </li>
        </ul>
      </React.Fragment>
    );

    const adminActions = (
      <React.Fragment>
        <p className="menu-label">
          Moderation
        </p>

        <ul className="menu-list">
          <li>
            <If condition={this.state.isLocked}>
              <Then>
                <a onClick={() => this.setState({ action: 'unlock' })}>
                  <span className="icon is-small">
                    <i className="fa fa-unlock" />
                  </span>

                  {' '}

                  <span>
                    Unlock
                  </span>
                </a>
              </Then>

              <Else>
                <a onClick={() => this.setState({ action: 'lock' })}>
                  <span className="icon is-small">
                    <i className="fa fa-lock" />
                  </span>

                  {' '}

                  <span>
                    Lock
                  </span>
                </a>
              </Else>
            </If>
          </li>

          <li>
            <a onClick={() => this.setState({ action: 'destroy' })}>
              <span className="icon is-small">
                <i className="fa fa-trash-alt" />
              </span>

              {' '}

              <span>
                Delete
              </span>
            </a>
          </li>
        </ul>
      </React.Fragment>
    );

    return (
      <aside className="menu">
        {userActions}
        {this.props.canModerate ? adminActions : null}
      </aside>
    );
  }

  nudge = () => {
    axios({
      method: 'post',
      url: this.props.nudge.nudgeEndpoint,
      data: {
        authenticity_token: this.props.authenticity_token,
        topic_id: this.props.topicID,
        user_id: this.props.currentUserID,
      }
    })
  }

  setLocked = (isLocked) => {
    this.setState({ isLocked });
  }

  clearAction = () => {
    this.setState({ action: null });
  }
}

export default TopicActions
