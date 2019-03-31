class Api::PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.new(post_params)
    post.user = current_user

    if post.save
      post_json = PostSerializer.new(post).serializable_hash
      render json: { post: post_json }

      ActionCable.server.broadcast(
        "topic_channel_#{post.topic_id}", 
        type: 'post',
        post: post_json,
      )
    else
      render json: { errors: post.errors.full_messages }
    end
  end

  private

  def post_params
    params.require(:post).permit(:topic_id, :content)
  end
end