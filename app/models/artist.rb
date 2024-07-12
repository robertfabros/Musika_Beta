class Artist < ApplicationRecord
  belongs_to :user
  has_many :music

  has_one_attached :profile_picture

  validates :bio, presence: true
  validates :profile_picture, presence: true

  after_commit :resize_profile_picture, if: :profile_picture_attached?

  private

  def resize_profile_picture
    profile_picture.variant(resize_to_limit: [300, 300]).processed
  end

  def profile_picture_attached?
    profile_picture.attached?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["bio", "created_at", "id", "id_value", "profile_picture", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["music", "profile_picture_attachment", "profile_picture_blob", "user"]
  end
end
