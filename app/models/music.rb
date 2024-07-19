class Music < ApplicationRecord
  belongs_to :artist
  belongs_to :genre
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :order_items
  has_many :reviews

  has_one_attached :file

  validates :title, presence: true
  validates :artist_id, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :file, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[artist_id genre_id created_at description id price title updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[artist cart_items file_attachment file_blob genre order_items reviews]
  end
end
