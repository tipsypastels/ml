class Api::ProfileUpdateController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.update(profile_update_params)
    render json: { response: :ok }
  end

  def profile_update_params
    params.require(:user).permit(:avatar, :name)
  end
end