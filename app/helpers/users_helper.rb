module UsersHelper
  def avatar_for(user, size: '48x48')
    <<~HTML.html_safe
      <figure class="avatar image is-#{size}">
        <img class="avatar-image" src="#{url_for(user.avatar)}" alt="#{user.username}'s Avatar"/>
      </figure>
    HTML
  end
end
