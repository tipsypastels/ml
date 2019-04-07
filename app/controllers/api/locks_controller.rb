class Api::LocksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_topic

  def create
    @topic.update(lock_reason: params[:reason])

    if params[:update]
      StatusBuilder.locked(@topic, current_user, reason: params[:reason])
    end

    broadcast(:lock)
    render json: { locked: true }
  end

  def destroy
    @topic.update(lock_reason: nil)

    if params[:update]
      StatusBuilder.unlocked(@topic, current_user)
    end

    broadcast(:unlock)
    render json: { locked: false }
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def broadcast(type)
    ActionCable.server.broadcast(
      "topic_channel_#{@topic.id}", 
      type: type,
    )
  end
end