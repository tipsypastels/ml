class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel_#{params[:user_id]}"
  end

  def send_follow(data)
    follower = User.find(data['from'])
    following = User.find(data['to'])

    follower.follow(following)
    update_count_for(following)
  end

  def send_unfollow(data)
    follower = User.find(data['from'])
    following = User.find(data['to'])

    follower.stop_following(following)
    update_count_for(following)
  end

  private

  def update_count_for(user)
    ActionCable.server.broadcast(
      "user_channel_#{params[:user_id]}",
      followers: user.followers.pluck(:id),
    )
  end
end