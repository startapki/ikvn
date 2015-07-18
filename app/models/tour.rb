class Tour < ActiveRecord::Base
  belongs_to :season

  has_many :problems, dependent: :destroy

  scope :active, -> { where('started_at <= ?', Time.zone.now) }

  validates :season, presence: true
  validates :name, uniqueness: { scope: :season }, allow_nil: true

  def active?
    started_at.present? && started_at <= Time.zone.now
  end

  def calculate_score_for(user)
    Score
    .joins(solution: [:participation, :problem])
    .where(problems: { tour_id: id },
           participations: { user_id: user.id })
    .sum(:value)
  end

  def finished?
    finished_at.present? && finished_at >= Time.zone.now
  end

  def reviewed?
    reviewed_at.present? && reviewed_at >= Time.zone.now
  end

  def solutionable?
    finished? && !reviewed?
  end
end
