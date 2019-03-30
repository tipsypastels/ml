class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[^\s!#$%^&*()（）=+;:'"\[\]\{\}|\\\/<>?,]+\z/ }

  has_many :topics
  has_many :posts
  has_one_attached :avatar

  acts_as_followable
  acts_as_follower

  before_save do
    username.downcase!
  end

  before_save :set_default_avatar

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
end
