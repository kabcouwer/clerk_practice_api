class Student < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :grade, presence: true
end
