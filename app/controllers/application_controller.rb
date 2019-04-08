class ApplicationController < ActionController::Base
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
    current_user&.in_club?(club)
  end
  helper_method :current_club_member?

  def authenticate_admin!
    redirect_to root_path unless current_admin?
  end
  helper_method :authenticate_admin!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end