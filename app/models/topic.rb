class Topic < ApplicationRecord
  default_scope do
    order(created_at: :desc)
  end

  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :posts
  belongs_to :user, counter_cache: true
  validates :title, presence: true

  delegate :username, to: :user

  TITLE_SQUEEZE_LENGTH = 27

  def title_squeezed
    if title.length > TITLE_SQUEEZE_LENGTH
      title.slice(0, 27) + '...'
    else
      title
    end
  end
end
