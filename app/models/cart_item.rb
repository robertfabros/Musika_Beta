# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :music

  validates :cart_id, presence: true
  validates :music_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Add this method to explicitly allowlist searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[cart_id created_at id music_id price quantity updated_at]
  end
end
