class Province < ApplicationRecord
  has_many :users
  has_many :orders

  validates :name, presence: true
  validates :gst, :pst, :qst, :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name gst pst qst hst created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[users orders]
  end
end
