class Student < ApplicationRecord
  has_one_attached :profile_picture, dependent: :purge_later

  validates :first_name, :last_name, :school_email, :major, :expected_graduation_date, presence: true
  validates :school_email, uniqueness: { message: "has already been registered. Please use a different email." }
  validates :school_email, format: { with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "must be an @msudenver.edu email address" }
end
