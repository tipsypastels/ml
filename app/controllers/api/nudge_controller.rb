class Api::NudgeController < ApplicationController
  include TopicsHelper

  def create
    @topic = Topic.find(params[:topic_id])
    @user  = User.find(params[:user_id])

    @topic.touch

    ActionCable.server.broadcast(
      "topic_channel_#{@topic.id}",
      type: 'nudge',
      post: {
        content: "<strong>#{@user.username}</strong> sent a nudge!",
        profileURL: url_for(@user),
        topicColor: color_for(@topic),
        isStatus: true,
        id: object_id,
      }
    )
  end
end