class League < ActiveRecord::Base
  has_many :tournaments, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
end
