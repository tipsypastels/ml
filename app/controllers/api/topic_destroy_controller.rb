class Api::TopicDestroyController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to root_path
  end
end