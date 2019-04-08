# Api::PostsController is used for most actions
class PostsController < ApplicationController
  def index
    @posts = post_scope
  end

  private

  ACTIVITY_COUNT = 25

  def post_scope
    if current_admin?
      Post.ordered.limit(25)
    elsif user_signed_in?
      Post.ordered.limit(25).scoped_to(current_user)
    else
      Post.ordered.limit(25).global_or_public_clubs
    end
  end
end