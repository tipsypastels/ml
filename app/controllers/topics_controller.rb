class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @topics = Topic.all.includes(:user)
  end

  def show
    @topic = Topic.friendly.find(params[:id])
    
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
end
