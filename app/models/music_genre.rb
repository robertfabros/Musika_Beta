# app/models/music_genre.rb
class MusicGenre < ApplicationRecord
  belongs_to :music
  belongs_to :genre

  validates :music_id, presence: true
  validates :genre_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[music_id genre_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[music genre]
  end
end
