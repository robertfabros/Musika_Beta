# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :music

  validates :cart_id, presence: true
  validates :music_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    price * quantity
  end

  def self.ransackable_associations(auth_object = nil)
    %w[cart music]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id cart_id music_id quantity price created_at updated_at]
  end
end
