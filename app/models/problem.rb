class Problem < ActiveRecord::Base
  belongs_to :tour

  has_many :solutions

  validates :name, :description, :tour, presence: true
end
