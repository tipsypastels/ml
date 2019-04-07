class StatusBuilder
  def self.method_missing(method, topic, user, **opts)
    new(method, topic, user, **opts).add
  end

  def initialize(method, topic, user, **opts)
    @method = method
    @topic  = topic
    @user   = user
    @opts   = opts
  end

  STATUS_MESSAGES = {
    locked: proc { |user, opts|
      <<~HTML
        <strong>#{user.username}</strong> locked the topic! <strong>Reason:</strong> #{opts[:reason]}
      HTML
    },

    unlocked: proc { |user, opts|
      <<~HTML
        <strong>#{user.username}</strong> unlocked the topic.
      HTML
    },
  }

  def add
    content = STATUS_MESSAGES[@method].call(@user, @opts)

    post = @topic.posts.create!(
      user: @user,
      is_status: true,
      content: @content,
    )

    NewPostBroadcaster.broadcast(post)
  end
end