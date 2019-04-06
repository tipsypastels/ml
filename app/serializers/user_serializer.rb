class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  alias user object
  
  attributes :id,
             :username,
             :avatarURL
  
  def avatarURL
    rails_blob_path(user.avatar, 
      disposition: 'attachment',
      only_path: true,
    )
  end
end
