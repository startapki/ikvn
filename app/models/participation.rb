class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  ROLES = %w(author jury)

  validates :user, :season, presence: true
  validates :user, uniqueness: { scope: [:season, :role] }
  validates :role, inclusion: { in: ROLES }
end
