# app/models/province.rb
class Province < ApplicationRecord
  has_many :users
  has_many :orders

  validates :name, presence: true
  validates :gst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :qst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
