class Season < ActiveRecord::Base
  belongs_to :tournament

  has_many :tours

  validates :tournament, presence: true
  validates :name, uniqueness: { scope: :tournament }, allow_nil: true
end
