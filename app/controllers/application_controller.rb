class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def current_username
    current_user&.username_at
  end
  helper_method :current_username

  def current_user?(user)
    current_user && current_user == user
  end
  helper_method :current_user?

  def current_admin?
    current_user&.admin?
  end
  helper_method :current_admin?

  def current_club_member?(club)
    current_user&.club?(club)
  end
  helper_method :current_club_member?

  def authenticate_admin!
    redirect_to root_path unless current_admin?
  end
  helper_method :authenticate_admin!

  # requires @topic variable to be in scope
  # use set_topic before this in the before_action chain
  def authenticate_admin_or_club_moderator!
    unless topic_permissions(@topic).can_moderate?
      redirect_to root_path
    end
  end
  helper_method :authenticate_admin_or_club_moderator!

  def topic_permissions(topic)
    @topic_permissions ||= TopicPermissions.new(topic, current_user)
  end
  helper_method :topic_permissions

  def can_post?(topic)
    topic_permissions(topic).can_post?
  end
  helper_method :can_post?

  def can_view?(topic)
    topic_permissions(topic).can_view?
  end
  helper_method :can_view?

  def create_permissions
    @create_permissions ||= CreatePermissions.new(current_user)
  end
  helper_method :topic_permissions

  def can_create?(club = nil)
    generic = create_permissions.can_create?
    return generic unless club

    generic && club_permissions(club).can_create_in?
  end
  helper_method :can_create?

  def club_permissions(club)
    @club_permissions ||= ClubPermissions.new(club, current_user)
  end
  helper_method :club_permissions

  def generate_club_join_tip
    @can_join = club_permissions(@club).can_join?
    
    unless @can_join
      @admin_override = club_permissions(@club).view_permissions == :not_club_member_but_admin
    end
  end
  helper_method :generate_club_join_tip

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end