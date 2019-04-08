class Api::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_can_post

  def create
    post = Post.new(post_params)

    if post.topic.locked? && !current_admin? 
      render json: { response: 403, error: 'Locked' }
      return
    end

    post.user = current_user
    post.admin &&= current_user.admin?

    if post.save
      NewPostBroadcaster.broadcast(post)
      render json: { response: :ok } 
    else
      render json: { errors: post.errors.full_messages }
    end
  end

  def update
    post = Post.find(params[:id])
    
    if !post || post.user != current_user
      return
    end
    
    post.content = params[:content]
    if post.save
      post_json = PostSerializer.new(post).serializable_hash
      render json: { post: post_json }
      
      ActionCable.server.broadcast(
        "topic_channel_#{post.topic_id}",
        type: 'post_edit',
        post: post_json,
      )
    else
      render json: { errors: post.errors.full_messages }
    end
  end

  private

  def post_params
    params.require(:post).permit(:topic_id, :content, :admin)
  end

  def verify_can_post
    topic = Topic.find(post_params[:topic_id])
    redirect_to root_path unless topic_permissions(topic).can_post?
  end
end