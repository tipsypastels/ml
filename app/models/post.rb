class Post < ApplicationRecord
  scope :ordered, -> {
    where(is_status: false).order(created_at: :desc)
  }

  scope :with_standalone_includes, -> {
    includes(:topic, :user, topic: :club)
  }

  scope :scoped_to, lambda { |user|
    with_standalone_includes.select do |post| 
      TopicPermissions.new(post.topic, user).can_view?
    end
  }

  scope :global_or_public_clubs, -> {
    with_standalone_includes.select do |post| 
      TopicPermissions.new(post.topic, nil).can_view?
    end
  }

  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user, counter_cache: true

  validates :content, presence: true

  delegate :username, :username_at, to: :user
  delegate :reading_time, to: :content

  def ever_updated?
    updated_at > created_at
  end

  def op?
    user == topic.user
  end

  def first?
    topic.first_post_id == id
  end

  def status?
    is_status
  end
end
