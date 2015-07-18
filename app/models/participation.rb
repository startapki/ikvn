class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  validates :user, :season, presence: true
  validates :user, uniqueness: { scope: [:season] }
end
