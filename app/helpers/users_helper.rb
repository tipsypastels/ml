module UsersHelper
  def avatar_for(user, size: 'normal')
    <<~HTML.html_safe
      <figure class="avatar image is-48x48">
        <img class="avatar-image" src="#{url_for(user.avatar)}" alt="#{user.username}'s Avatar"/>
      </figure>
    HTML
  end

  def can_post?(topic = nil)
    if topic
      user_signed_in? && (topic.unlocked? || current_admin?)
    else
      user_signed_in? # TODO banned
    end
  end
end
