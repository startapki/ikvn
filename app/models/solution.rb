class Solution < ActiveRecord::Base
  belongs_to :problem, counter_cache: true
  belongs_to :participation

  validates :content, :problem, :participation, presence: true
  validates :problem, uniqueness: { scope: :participation }
end
