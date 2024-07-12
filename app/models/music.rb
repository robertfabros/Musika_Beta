class Music < ApplicationRecord
  belongs_to :artist
  has_many :cart_items
  has_many :order_items
  has_many :reviews
  has_many :music_genres
  has_many :genres, through: :music_genres

  has_one_attached :file

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :file, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[artist_id created_at description id price title updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[artist cart_items file_attachment file_blob genres music_genres order_items reviews]
  end
end
