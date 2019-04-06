class Post < ApplicationRecord
  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user, counter_cache: true

  validates :content, presence: true

  delegate :username, :username_at, to: :user
  delegate :reading_time, to: :content

  def ever_updated?
    created_at == updated_at
  end

  def op?
    user == topic.user
  end

  def admin?
    false # TODO
  end
end
