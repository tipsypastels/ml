class Api::TopicDestroyController < ApplicationController
  before_action :set_topic
  before_action :authenticate_admin_or_club_moderator!

  def destroy
    @topic.destroy
    redirect_to root_path
  end
  
  private
  
  def set_topic
    @topic = Topic.find(params[:id])
  end
end