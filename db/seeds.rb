# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker' # Make sure the Faker gem is installed
require 'open-uri' # To open the image URL

# Purge existing profile photos and remove associated blobs and attachments
Student.find_each do |student|
 student.profile_picture.purge if student.profile_picture.attached?
end

# Ensure there are no orphaned attachments or blobs
ActiveStorage::Blob.where.missing(:attachments).find_each(&:purge)

# The above doesn’t delete the empty folders
# run the following to remove empty folders
# find storage/ -type d -empty -delete

Student.destroy_all # Clear existing records if any

50.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  minorprob = rand < 0.15 ? Faker::Educator.subject : nil


 student = Student.create!(
   first_name: first_name,
   last_name: last_name,
   school_email: "#{first_name.downcase.gsub(/[^a-z]/, '')}.#{last_name.downcase.gsub(/[^a-z]/, '')}@msudenver.edu",
   major: Faker::Educator.subject,
   minor: minorprob,
   expected_graduation_date: Faker::Date.between(from: 2.years.ago, to: 2.years.from_now),

 )
  # Generate a unique profile pic based on the student's name
  profile_picture_url = "https://robohash.org/#{student.first_name.gsub(' ', '')}"
  profile_picture = URI.open(profile_picture_url)
  student.profile_picture.attach(io: profile_picture, filename: "#{student.first_name}.jpg")
end

puts "50 students created."
