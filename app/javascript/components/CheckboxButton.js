import React from 'react';

export default function(props) {
  let buttonClass;
  let iconClass;

  if(props.active) {
    buttonClass = props.activeClass || 'primary';
    iconClass = props.activeIcon || 'check';
  } else {
    buttonClass = props.passiveClass || 'text';
    iconClass = props.passiveIcon || 'times'
  }

  return (
    <label 
      className={`button is-${buttonClass} ${props.className}`}
      onChange={props.onChange}
    >
      <input 
        style={{ display: 'none' }}
        type="checkbox" 
        defaultChecked={props.active}
      />
      <span className="icon is-small">
        <i className={`fas fa-${iconClass}`} />
      </span>

      <span>
        {props.children}
      </span>
    </label>
  );
}

/*
<label className="button is-success">
      <span className="icon is-small">
        <i className="fas fa-check" />
      </span>
      <span>Save</span>
    </label>
    */