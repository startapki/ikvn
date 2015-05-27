class Tournament < ActiveRecord::Base
  belongs_to :league

  has_many :seasons

  validates :name, :league, presence: true
  validates :name, uniqueness: { scope: :league }
end
