# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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

  enum role: { customer: 'Customer', artist: 'Artist' }

  def self.ransackable_attributes(auth_object = nil)
    %w[address created_at email id name province_id role updated_at]
  end

  # Add this method to explicitly allowlist searchable associations
  def self.ransackable_associations(auth_object = nil)
    %w[artists carts orders reviews province]
  end
end
