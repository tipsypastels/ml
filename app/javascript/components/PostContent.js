import React from 'react';
import Timeago from './Timeago';

export default class extends React.Component {
  render() {
    if (this.props.editing) {
      return (
        <React.Fragment>
          <textarea
            autoFocus
            className="textarea margin-bottom"
            onChange={this.props.setContent}
            defaultValue={this.props.content}
          />

          <div className="buttons">
            <div 
              className={`button is-${this.props.topicColor}`} 
              onClick={this.props.saveEdits}
            >
              Save
            </div>
            
            <div 
              className="button is-light" 
              onClick={this.props.cancelEdits}
            >
              Cancel
            </div>
          </div>
        </React.Fragment>
      );
    } else {
      return (
        <React.Fragment>
          <div className="post-meta">
            <div className="level">
              <div className="level-left">
                <a href={this.props.profileURL}>
                  {this.props.username}
                </a>
              </div>

              <div className="level-right">
                <Timeago since={this.props.createdAt} />
              </div>
            </div>
          </div>

          <div className="post-content">
            <div
              className="content"
              onDoubleClick={this.props.toggleEditing}
              dangerouslySetInnerHTML={{
                __html: this.props.markdownContent,
              }}
            />
          </div>
        </React.Fragment>
      );
    }
  }
}