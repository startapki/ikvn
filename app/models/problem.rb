class Problem < ActiveRecord::Base
  default_scope -> { order(position: :asc) }

  belongs_to :tour

  has_many :solutions, dependent: :restrict_with_exception

  acts_as_list scope: :tour

  validates :content, :tour, presence: true

  def solutions?
    solutions.size > 0
  end
end
