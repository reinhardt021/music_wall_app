class User < ActiveRecord::Base
  has_many :votes
  has_many :tracks

  validates :email, presence: true
  validates :password, presence: true
end