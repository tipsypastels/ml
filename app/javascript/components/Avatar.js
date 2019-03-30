import React from 'react';

export default function(props) {
  return (
    <img 
      src={props.url} 
      className={`avatar avatar-${props.size || 'normal'}`} 
    />
  );
}