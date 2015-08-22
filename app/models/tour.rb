class Tour < ActiveRecord::Base
  belongs_to :season

  has_many :problems, dependent: :destroy

  scope :active, -> { where('started_at <= ?', Time.zone.now) }

  validates :season, presence: true
  validates :name, uniqueness: { scope: :season }, allow_nil: true
  validate :finished_at_greater_than_started_at,
           :reviewed_at_greater_than_finished_at,
           :reviewed_at_greater_than_started_at

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
    finished_at.present? && finished_at <= Time.zone.now
  end

  def reviewed?
    reviewed_at.present? && reviewed_at <= Time.zone.now
  end

  def solutionable?
    active? && !finished? && !reviewed?
  end

  private

  def finished_at_greater_than_started_at
    greater_than :finished_at, :started_at
  end

  def reviewed_at_greater_than_finished_at
    greater_than :reviewed_at, :finished_at
  end

  def reviewed_at_greater_than_started_at
    greater_than :reviewed_at, :started_at
  end

  def greater_than(first, second)
    first_value = self[first.to_sym]
    second_value = self[second.to_sym]
    if first_value.present? && second_value.present? && first_value < second_value
      errors.add(first.to_sym, "should be greater than #{second}")
    end
  end
end
