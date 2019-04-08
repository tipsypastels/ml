module ClubsHelper
  def club_image_for(club, size: '48x48')
    <<~HTML.html_safe
      <figure class="image is-#{size}">
        <img class="club-image" src="#{url_for(club.image)}" alt="#{club.title}"/>
      </figure>
    HTML
  end

  def in_any_clubs?
    current_user&.clubs.present?
  end
end