class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  alias user object
  
  attributes :id,
             :type,
             :username,
             :avatarURL,
             :profileURL
  
  def type
    'user'
  end

  def avatarURL
    rails_blob_path(user.avatar, 
      disposition: 'attachment',
      only_path: true,
    )
  end

  def profileURL
    user_path(user)
  end
end
