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

  def self.ransackable_attributes(auth_object = nil)
    %w[bio created_at id updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[music user]
  end
end
