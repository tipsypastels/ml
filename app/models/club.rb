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
  has_many :club_memberships, dependent: :destroy
  has_many :users, through: :club_memberships
  has_many :invites

  has_one_attached :image

  validates :title, presence: true
  
  enum visibility: {
    vis_public:  0,
    vis_private: 1,
  }

  before_save :set_default_image

  def moderators
    club_memberships.where(moderator: true).collect(&:user)
  end

  def members
    club_memberships.order(moderator: :desc).collect(&:user)
  end

  def regular_members
    members - moderators
  end

  def add_user(user, moderator: false)
    ClubMembership.create!(
      user_id: user.id, 
      club_id: id, 
      moderator: moderator,
    )
  end

  DEFAULT_IMAGE_PATH = Rails.root.join('app/assets/images/default_avatar.jpg')
  private_constant :DEFAULT_IMAGE_PATH

  def set_default_image(force: false)
    return if image.attached? && !force
    image.attach(io: File.open(DEFAULT_IMAGE_PATH), filename: 'image.jpg')
  end

  def valid_join_hex?(hex)
    invites.find_by(hex: hex).presence
  end
end