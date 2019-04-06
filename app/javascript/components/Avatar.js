import React from 'react';

export default function({ url, size }) {
  return (
    <figure className={`avatar image is-${size || '48x48'}`}>
      <img className="avatar-image" src={url} />
    </figure>
  );
};