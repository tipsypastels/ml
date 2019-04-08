class Topic < ApplicationRecord
  default_scope do
    order(updated_at: :desc)
  end

  scope :without_clubs, -> {
    where(club_id: nil)
  }

  acts_as_taggable

  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_many :posts, dependent: :destroy
  belongs_to :user, counter_cache: true

  belongs_to :club, optional: true, touch: true
  
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

  def reading_time(*args)
    posts.collect(&:content).join("\n").reading_time(*args)
  end

  def likes_count
    0 # TODO
  end

  def locked?
    lock_reason.present?
  end

  def unlocked?
    not locked?
  end

  def club?
    club.present?
  end

  def global?
    not club?
  end

  def private_club?
    club? && club.vis_private?
  end
end
