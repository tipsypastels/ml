import React, { Component } from 'react'

export default class PostReplyDisabled extends Component {
  render() {
    const { header, body } = this.generateContent();

    return (
      <div className={`PostReply message is-${this.props.topicColor}`}>
        <div className="message-header">
          {header}
        </div>

        <div className="message-body">
          {body}
        </div>
      </div>
    )
  }

  generateContent() {
    let header;
    let body;
    switch(this.props.topicPermissions) {
      case 'logged_out': {
        header = (
          <span>
            Want to participate in the discussion?
          </span>
        );

        body = (
          <a href={this.props.registerEndpoint}>
            Click here to register on Meteor Lens!
          </a>
        );

        break;
      }

      case 'banned': {
        header = (
          <span>
            You may not reply to this topic.
          </span>
        );

        body = (
          <span>
            You are banned from Meteor Lens. If you believe this is an error, please contact an admin.
          </span>
        );

        break;
      }

      case 'locked': {
        header = (
          <span>
            This topic is locked.
          </span>
        );

        body = (
          <span>
            Members will not be able to reply. Sorry about that!
          </span>
        );

        break;
      }

      case 'not_club_member': {
        header = (
          <span>
            Join this group to participate in this topic!
          </span>
        );

        body = (
          <a 
            className={`button is-${this.props.topicColor}`} 
            href={this.props.joinClubEndpoint}
          >
            Join Club
          </a>
        );

        break;
      }
    }

    return { header, body };
  }
}
