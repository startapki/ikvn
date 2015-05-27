class Solution < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user

  validates :content, :problem, :user, presence: true
end
