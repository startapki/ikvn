class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { user: 0, judge: 1, admin: 2 }

  has_many :participations, dependent: :destroy
  has_many :solutions, dependent: :destroy

  validates :name, presence: true
end
