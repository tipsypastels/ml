class UserSettingsController < ApplicationController
  before_action :authenticate_user!

  def profile
  end

  def save
    get_params = settings_params
    back = get_params.delete(:back)

    normalizer = SocialMediaNormalizer.new(get_params)
    normalizer.normalize!

    if current_user.update(get_params)
      redirect_to current_user
    else
      render back
    end
  end

  private

  def settings_params
    params.permit(
      :avatar, 
      :name, 
      :interests,
      :biography,
      :age, 
      :gender, 
      :location,
      :relationship_status,
      :facebook,
      :twitter,
      :discord,
    )
  end
end
