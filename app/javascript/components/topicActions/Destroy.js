import React, { Component } from 'react'

export default class Destroy extends Component {
  render() {
    return (
      <div>
        <label className="label">
          Really delete?
        </label>

        <div className="field has-addons">
          <div className="control is-expanded">
            <button
              className="button is-light is-fullwidth" 
              onClick={this.props.clearAction}
            >
              Back
            </button>
          </div>

          <div className="control">
            <a 
              className="button is-danger"
              href={this.props.destroyEndpoint}
              data-method="delete"
            >
              Really Delete
            </a>
          </div>
        </div>
      </div>
    )
  }
}
