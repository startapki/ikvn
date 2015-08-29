class Season < ActiveRecord::Base
  belongs_to :tournament

  has_many :tours, dependent: :destroy
  has_many :participations, dependent: :destroy

  scope :active, -> { joins(:tours).merge(Tour.active).uniq }

  validates :name, :tournament, presence: true
  validates :name, uniqueness: { scope: :tournament }, allow_nil: true

  def active?
    tours.active.exists?
  end
end
