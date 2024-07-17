# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


# Page.find_or_create_by(slug: 'about') do |page|
#   page.title = 'About Us'
#   page.content = 'This is the about page content.'
# end

# Page.find_or_create_by(slug: 'contact') do |page|
#   page.title = 'Contact Us'
#   page.content = 'This is the contact page content.'
# end


# genres = [
#   "Rock",
#   "Pop",
#   "Hip Hop/Rapgit ad",
#   "R&B/Soul",
#   "Electronic/Dance",
#   "Country",
#   "Jazz",
#   "Classical",
#   "Reggae",
#   "Blues",
#   "Metal",
#   "Latin",
#   "Folk",
#   "World Music",
#   "Gospel/Christian",
#   "New Age"
# ]

# genres.each do |genre|
#   Genre.create(name: genre)
# end

# provinces = [
#   { name: 'Alberta', gst: 0.05, pst: 0, qst: 0, hst: 0 },
#   { name: 'British Columbia', gst: 0.05, pst: 0.07, qst: 0, hst: 0 },
#   { name: 'Manitoba', gst: 0.05, pst: 0.07, qst: 0, hst: 0 },
#   { name: 'New Brunswick', gst: 0, pst: 0, qst: 0, hst: 0.15 },
#   { name: 'Newfoundland and Labrador', gst: 0, pst: 0, qst: 0, hst: 0.15 },
#   { name: 'Nova Scotia', gst: 0, pst: 0, qst: 0, hst: 0.15 },
#   { name: 'Ontario', gst: 0, pst: 0, qst: 0, hst: 0.13 },
#   { name: 'Prince Edward Island', gst: 0, pst: 0, qst: 0, hst: 0.15 },
#   { name: 'Quebec', gst: 0.05, pst: 0, qst: 0.09975, hst: 0 },
#   { name: 'Saskatchewan', gst: 0.05, pst: 0.06, qst: 0, hst: 0 },
#   { name: 'Northwest Territories', gst: 0.05, pst: 0, qst: 0, hst: 0 },
#   { name: 'Nunavut', gst: 0.05, pst: 0, qst: 0, hst: 0 },
#   { name: 'Yukon', gst: 0.05, pst: 0, qst: 0, hst: 0 }
# ]

# provinces.each do |province|
#   Province.find_or_create_by(province)
# end

# This is for Seeding 100 Products using Faker
# require 'faker'

# # Ensure we have genres and artists in the database
# genres = Genre.all
# artists = Artist.all

# if genres.empty?
#   puts "No genres found. Please create some genres first."
#   exit
# end

# if artists.empty?
#   puts "No artists found. Please create some artists first."
#   exit
# end

# # Create a directory to store sample mp3 files for testing
# mp3_files_dir = Rails.root.join('db', 'seeds', 'mp3_files')
# Dir.mkdir(mp3_files_dir) unless Dir.exist?(mp3_files_dir)

# # Ensure there are at least 10 mp3 files
# 10.times do |i|
#   file_path = mp3_files_dir.join("#{i + 1}.mp3")
#   File.write(file_path, "Sample content for MP3 file #{i + 1}") unless File.exist?(file_path)
# end

# # Seed 100 music tracks

# require 'faker'

# # Define the directory containing your MP3 files
# mp3_files_dir = Rails.root.join('db', 'seeds', 'mp3_files')

# # Assuming you have some artists and genres already created
# artists = Artist.all
# genres = Genre.all

# # Seed 100 music tracks
# 100.times do
#   music = Music.new(
#     artist: artists.sample,
#     title: Faker::Music.album,
#     price: Faker::Commerce.price(range: 0..10.0),
#     description: Faker::Lorem.paragraph
#   )

#   # Attach an MP3 file
#   file_path = mp3_files_dir.join("#{rand(1..10)}.mp3")
#   music.file.attach(io: File.open(file_path), filename: "#{rand(1..10)}.mp3", content_type: 'audio/mpeg')

#   # Select random genres
#   selected_genres = genres.sample(rand(1..3))
#   music.genre_id = selected_genres.first.id

#   # Save the music record
#   if music.save
#     puts "Created music: #{music.title} with genre: #{selected_genres.first.name}"
#   else
#     puts "Failed to create music: #{music.errors.full_messages.join(', ')}"
#   end
# end

# puts "Seeded 100 music tracks"

# Seed music.csv
