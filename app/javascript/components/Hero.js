import React, { Component } from 'react'
import When from 'react-if';
import axios from 'axios';

import Avatar from './Avatar';

export default class Hero extends Component {
  constructor(props) {
    super(props);
    this.state = {
      text: '',
      results: [],
    };
  }

  render() {
    return (
      <section className="hero is-primary">
        <div className="hero-body">
          <div className="container">
            <h1 className="title">
              Welcome
            </h1>
            <h2 className="subtitle">
              Search for topics, tags or users.
            </h2>

            <input 
              type="text"
              className="hero-search input"
              onChange={this.setText}
              value={this.state.text}
              autoFocus
            />

            <When condition={this.state.results.length > 0}>
              <aside className="menu">
                <ul className="menu-list">
                  {this.buildResults()}
                </ul>
              </aside>
            </When>
          </div>
        </div>
      </section>
    )
  }

  buildResults() {
    return this.state.results.map(result => {
      console.log(result);
      switch(result.type) {
      case 'user':
        return (
          <li key={`user-${result.id}`}>
            <a className="flex flex-center" href={result.profileURL}>
              <Avatar url={result.avatarURL} size="32x32" />

              <span className="column">
                {result.username}
              </span>
            </a>
          </li>
        );
      }
    });
  }

  setText = (e) => {
    this.setState({ text: e.target.value }, this.search);
  }

  search = () => {
    if (!this.state.text) {
      this.setState({ results: [] });
      return;
    }

    axios({
      method: 'post',
      url: this.props.searchEndpoint,
      data: { 
        text: this.state.text,
        authenticity_token: this.props.authenticity_token,
      }
    }).then(({ data }) => this.setState({ results: data.results }));
  }
}
