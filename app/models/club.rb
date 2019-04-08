class Club < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope do
    order(updated_at: :desc)
  end

  scope :public_clubs, -> {
    where(visibility: 0)
  }

  has_many :topics
  has_many :club_memberships
  has_many :users, through: :club_memberships

  has_one_attached :image

  validates :title, presence: true

  def admins
    club_memberships.where(admin: true).pluck(:user)
  end

  enum visibility: {
    vis_public:  0,
    vis_private: 1,
  }
end