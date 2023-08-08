class User < ApplicationRecord
  has_many :students
  has_many :assignments
  has_many :roles, through: :assignments

  validates :email, presence: true, uniqueness: true
end
