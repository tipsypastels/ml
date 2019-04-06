class PostBadgeBuilder
  def initialize(post)
    @post = post
  end

  BADGES = {
    admin?: {
      short: 'Admin',
      long: 'Admin Post',
    },

    op?: {
      short: 'OP',
      long: 'Original Poster',
    }
  }

  def build!
    badges = []
    BADGES.each do |callback, text|
      next unless @post.send(callback)
      badges << text
    end

    return if badges.empty?

    if badges.length == 1
      badges.first[:long]
    else
      badges.collect { |b| b[:short] }.join(' / ')
    end
  end
end