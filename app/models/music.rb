# app/models/music.rb
class Music < ApplicationRecord
  belongs_to :artist
  belongs_to :genre
  has_many :cart_items
  has_many :order_items
  has_many :reviews

  validates :title, presence: true
  validates :genre, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :file_url, presence: true
  validates :description, presence: true
end
