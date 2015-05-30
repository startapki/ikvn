class Tour < ActiveRecord::Base
  default_scope -> { order(started_at: :desc) }

  belongs_to :season

  has_many :problems, dependent: :destroy

  scope :active, -> { where('started_at <= ?', Time.now) }

  validates :season, presence: true
  validates :name, uniqueness: { scope: :season }, allow_nil: true

  def active?
    started_at.present? && started_at <= Time.now
  end
end
