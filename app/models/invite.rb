class Invite < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates :hex, presence: true

  delegate :username, to: :user
  delegate :title, to: :club, prefix: true
end
