class Season < ActiveRecord::Base
  belongs_to :tournament

  has_many :tours, dependent: :destroy
  has_many :participations, dependent: :destroy

  scope :order_by_earliest_tour, lambda {
    select('seasons.*, MIN(t.started_at) as earliest_tour_started_at')
    .joins('LEFT OUTER JOIN tours AS t ON seasons.id = t.season_id')
    .order('earliest_tour_started_at DESC')
    .group('seasons.id')
  }

  scope :active, -> { joins(:tours).merge(Tour.active).uniq }

  validates :name, :tournament, presence: true
  validates :name, uniqueness: { scope: :tournament }, allow_nil: true

  def active?
    tours.active.exists?
  end
end
