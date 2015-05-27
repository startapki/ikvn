class Tour < ActiveRecord::Base
  belongs_to :season

  has_many :problems

  validates :season, presence: true
  validates :name, uniqueness: { scope: :season }, allow_nil: true
end
