import React from 'react';
import Moment from 'react-moment';

export const TIMEAGO_FILTER = function(date) {
  if (!/^\d+/.test(date)) {
    return date;
  }

  let firstSpace = date.indexOf(' ');
  return date.slice(0, firstSpace + 2).replace(' ', '');
}

export default function(props) {
  return (
    <span className="has-text-grey-light">
      <Moment 
        fromNow
        date={props.since} 
        filter={props.filter || TIMEAGO_FILTER}
      />
    </span>
  );
}