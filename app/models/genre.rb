class Genre < ApplicationRecord
  has_many :music_genres
  has_many :music, through: :music_genres

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[music music_genres]
  end
end
