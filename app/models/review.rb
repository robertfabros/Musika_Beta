# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :music

  validates :user_id, presence: true
  validates :music_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true
end
