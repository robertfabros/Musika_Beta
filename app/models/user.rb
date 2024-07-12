# app/models/user.rb
class User < ApplicationRecord
  has_many :artists
  has_many :carts
  has_many :orders
  has_many :reviews
  belongs_to :province

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :role, presence: true
  validates :address, presence: true
end
