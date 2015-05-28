class Season < ActiveRecord::Base
  belongs_to :tournament

  has_many :tours, dependent: :destroy

  scope :active, -> { joins(:tours).merge(Tour.active).uniq }

  validates :tournament, presence: true
  validates :name, uniqueness: { scope: :tournament }, allow_nil: true

  def active?
    tours.active.exists?
  end
end
