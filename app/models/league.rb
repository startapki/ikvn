class League < ActiveRecord::Base
  has_many :tournaments

  validates :name, presence: true
  validates :name, uniqueness: true
end
