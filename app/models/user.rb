class User < ApplicationRecord
  has_many :students
  has_many :assignments
  has_many :roles, through: :assignments

  validates :clerk_id, presence: true, uniqueness: true
end
