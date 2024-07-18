class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :musics, through: :cart_items

  validates :user_id, presence: true

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end

  def self.ransackable_associations(auth_object = nil)
    %w[cart_items user musics]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id user_id created_at updated_at]
  end
end
