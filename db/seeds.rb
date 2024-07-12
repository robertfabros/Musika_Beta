# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


# Page.find_or_create_by(slug: 'about') do |page|
#   page.title = 'About Us'
#   page.content = 'This is the about page content.'
# end

# Page.find_or_create_by(slug: 'contact') do |page|
#   page.title = 'Contact Us'
#   page.content = 'This is the contact page content.'
# end


genres = [
  "Rock",
  "Pop",
  "Hip Hop/Rapgit ad",
  "R&B/Soul",
  "Electronic/Dance",
  "Country",
  "Jazz",
  "Classical",
  "Reggae",
  "Blues",
  "Metal",
  "Latin",
  "Folk",
  "World Music",
  "Gospel/Christian",
  "New Age"
]

genres.each do |genre|
  Genre.create(name: genre)
end
