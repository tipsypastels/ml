class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_topic, only: :show
  before_action :verify_private, only: :show

  def index
    @topics = Topic.without_clubs.includes(:user, :tags)
  end

  def show
    posts = @topic.posts.includes(:user)

    # @HACK there should be a way of doing this without parsing
    @posts_json = JSON.parse(ActiveModel::Serializer::ArraySerializer
      .new(posts, each_serializer: PostSerializer)
      .to_json)
  end

  def new
    @topic = Topic.new
  end

  def create
    unless can_create?
      redirect_to root_path
      return
    end

    builder = TopicBuilder.new(topic_params, current_user)
    
    if builder.save
      redirect_to builder.topic
    else
      render 'new'
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content, :tag_list)
  end

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  def verify_private
    return unless @topic.private_club?
    redirect_to root_path unless can_view?(@topic)
  end
end
