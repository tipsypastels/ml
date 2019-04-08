class ClubTopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_club
  before_action :authenticate_club_member!

  def new
    @topic = Topic.new
  end

  def create
    builder = TopicBuilder.new(club_topic_params, current_user)
    builder.topic.club = @club

    if builder.save
      redirect_to builder.topic
    else
      render 'new'
    end
  end

  private

  def set_club
    @club = Club.friendly.find(params[:id])
  end

  def authenticate_club_member!
    redirect_to root_path unless current_user.in_club?(@club)
  end

  def club_topic_params
    params.permit(:title, :content, :tag_list)
  end
end