# Api::PostsController is used for most actions
class PostsController < ApplicationController
  def index
    @posts = post_scope
  end

  private

  def post_scope
    if current_admin?
      Post.all
    elsif user_signed_in?
      Post.scoped_to(current_user)
    else
      Post.global_or_public_clubs
    end
  end
end