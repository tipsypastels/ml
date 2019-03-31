class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include MarkdownHelper

  alias post object

  attributes :id, 
             :content, 
             :username,
             :profileURL,
             :avatarURL,
             :userIsOP
  
  def content
    markdown_for post.content
  end

  def username
    post.username_at
  end

  def profileURL
    user_path(post.user)
  end

  def avatarURL
    rails_blob_path(post.user.avatar, 
      disposition: 'attachment',
      only_path: true
    )
  end

  def userIsOP
    post.user == post.topic.user
  end
end