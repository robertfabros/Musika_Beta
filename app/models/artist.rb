# app/models/artist.rb
class Artist < ApplicationRecord
  belongs_to :user
  has_many :music

  validates :bio, presence: true
  validates :profile_picture, presence: true
end
