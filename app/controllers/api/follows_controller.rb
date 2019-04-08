class Api::FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :not_self

  def create
    current_user.follow(@user)
    render json: { status: :ok }
  end

  def destroy
    current_user.stop_following(@user)
    render json: { status: :ok }
  end

  private

  def find_user
    @user = User.unscoped.friendly.find(params[:id])
  end

  def not_self
    raise "Can't follow self" if current_user?(@user)
  end
end