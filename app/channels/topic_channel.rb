class TopicChannel < ApplicationCable::Channel
  def subscribed
    stream_from "topic_channel_#{params[:topic_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_typing(data)
    username = data['username']

    stream(username, :started_typing)

  end

  def send_stopped_typing(data)
    username = data['username']
    
    stream(username, :stopped_typing)
  end

  private

  def stream(username, type)
    ActionCable.server.broadcast(
      "topic_channel_#{params[:topic_id]}",
      type: type, 
      username: username,
    )
  end
end
