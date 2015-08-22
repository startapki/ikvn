class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  has_many :score

  validates :user, :season, presence: true
  validates :user, uniqueness: { scope: [:season] }

  def self.wants_email(role)
    joins(:user).preload(:user).where(users: { role: role, wants_email: true })
  end
end
