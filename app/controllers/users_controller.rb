class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.unscoped.friendly.find(params[:id])
  end
end