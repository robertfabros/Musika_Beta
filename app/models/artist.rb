# app/models/artist.rb
class Artist < ApplicationRecord
  belongs_to :user
  has_many :music

  has_one_attached :profile_picture

  validates :bio, presence: true
  validates :profile_picture, presence: true

  before_save :resize_profile_picture

  private

  def resize_profile_picture
    return unless profile_picture.attached?

    profile_picture.variant(resize_to_limit: [300, 300]).processed
  end
end
