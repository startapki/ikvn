class Score < ActiveRecord::Base
  belongs_to :solution
  belongs_to :participation
end
