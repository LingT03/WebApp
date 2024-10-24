class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture, dependent: :purge_later

  validates :first_name, :last_name, :major, :expected_graduation_date, presence: true
  validate :email_format
  def email_format
      unless email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
          errors.add(:email, "must be an @msudenver.edu email address")
      end
  end
end
