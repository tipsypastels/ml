module UsersHelper
  def avatar_for(user, size: 'normal')
    image_tag(user.avatar, class: "avatar avatar-#{size}")
  end

  def can_post?
    user_signed_in?
  end
end
