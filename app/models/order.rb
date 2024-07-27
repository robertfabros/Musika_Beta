class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

  validates :user_id, :province_id, :total_price, :status, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending paid shipped] }

  def calculate_total_price
    item_total = order_items.sum(&:total_price)
    gst = province.gst * item_total
    pst = province.pst * item_total
    qst = province.qst * item_total
    hst = province.hst * item_total
    self.total_price = item_total + gst + pst + qst + hst
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id user_id province_id total_price status created_at updated_at stripe_payment_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user province order_items]
  end
end
