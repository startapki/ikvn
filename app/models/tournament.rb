class Tournament < ActiveRecord::Base
  belongs_to :league

  has_many :seasons, dependent: :destroy
  has_many :tours, through: :seasons

  validates :name, :league, presence: true
  validates :name, uniqueness: { scope: :league }
end
