# app/models/order_item.rb
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :music

  validates :order_id, :music_id, :quantity, :price, presence: true

  def total_price
    price * quantity
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id order_id music_id quantity price created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[order music]
  end
end
