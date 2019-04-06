class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include MarkdownHelper
  include TopicsHelper

  alias post object

  attributes :id, 
             :content,
             :markdownContent,
             :user_id, 
             :username,
             :profileURL,
             :badgeContent,
             :avatarURL,
             :userIsOP,
             :createdAt,
             :updatedAt,
             :everUpdated,
             :topicColor
  
  def markdownContent
    markdown_for post.content
  end

  def profileURL
    user_path(post.user)
  end

  def badgeContent
    PostBadgeBuilder.new(post).build!
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

  def createdAt
    post.created_at
  end

  def updatedAt
    post.updated_at
  end

  def everUpdated
    post.ever_updated?
  end

  def topicColor
    color_for(post.topic)
  end
end