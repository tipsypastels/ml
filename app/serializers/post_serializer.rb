class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, 
             :content, 
             :username,
             :profileURL,
             :avatarURL,
             :userIsOP
  
  def username
    object.username_at
  end

  def profileURL
    user_path(object.user)
  end

  def avatarURL
    rails_blob_path(object.user.avatar, 
      disposition: 'attachment',
      only_path: true
    )
  end

  def userIsOP
    object.user == object.topic.user
  end
end