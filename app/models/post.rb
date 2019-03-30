class Post < ApplicationRecord
  belongs_to :topic, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :content, presence: true

  delegate :username, :username_at, to: :user
end
