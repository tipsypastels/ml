class User < ApplicationRecord
  default_scope do
    order('username ASC')
  end

  extend FriendlyId
  friendly_id :username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[^\s!#$%^&*()（）=+;:'"\[\]\{\}|\\\/<>?,]+\z/ }

  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :club_memberships
  has_many :clubs, through: :club_memberships

  has_one_attached :avatar

  acts_as_followable
  acts_as_follower

  before_save do
    username.downcase!
  end

  before_save :set_default_avatar

  enum gender: {
    female:    0,
    male:      1,
    nonbinary: 2,
    other:     3,
  }

  enum relationship_status: {
    single:  0,
    taken:   1,
    married: 2,
    open:    3,
  }

  def about_info?
    age? || gender? || location? || relationship_status?
  end

  def social_media?
    facebook? || twitter? || discord?
  end

  def username_at
    "@#{username}"
  end

  def name?
    name.present?
  end

  DEFAULT_AVATAR_PATH = Rails.root.join('app/assets/images/default_avatar.jpg')
  private_constant :DEFAULT_AVATAR_PATH

  def set_default_avatar(force: false)
    return if avatar.attached? && !force
    avatar.attach(io: File.open(DEFAULT_AVATAR_PATH), filename: 'avatar.jpg')
  end

  def in_club?(club)
    clubs.include?(club)
  end
end
