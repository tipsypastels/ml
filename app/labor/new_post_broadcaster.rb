class NewPostBroadcaster
  def self.broadcast(post)
    new(post).broadcast
  end

  def initialize(post)
    @post = post
  end

  def broadcast
    post_json = 
      if @post.is_a?(Hash)
        @post
      else
        PostSerializer.new(@post).serializable_hash
      end

    ActionCable.server.broadcast(
      "topic_channel_#{@post.topic_id}", 
      type: 'post',
      post: post_json,
    )

    post_json
  end
end