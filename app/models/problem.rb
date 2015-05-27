class Problem < ActiveRecord::Base
  belongs_to :tour

  has_many :solutions

  validates :title, :description, :tour, presence: true
end
