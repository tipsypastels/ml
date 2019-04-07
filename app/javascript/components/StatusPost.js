import React, { Component } from 'react'

export default class StatusPost extends Component {
  render() {
    return (
      <div className={`StatusPost notification is-${this.props.topicColor}`}>
        <a 
          href={this.props.profileURL}
          dangerouslySetInnerHTML={{ __html: this.props.content }}
        />
      </div>
    )
  }
}
