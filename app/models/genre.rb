# app/models/genre.rb
class Genre < ApplicationRecord
  has_many :music

  validates :name, presence: true, uniqueness: true
end
