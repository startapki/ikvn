class Solution < ActiveRecord::Base
  belongs_to :problem, counter_cache: true
  belongs_to :participation

  has_many :scores

  validates :content, :problem, :participation, presence: true
  validates :problem, uniqueness: { scope: :participation }

  def score_for(participation)
    scores.find_or_initialize_by(participation_id: participation_id)
  end
end
