class Genre < ApplicationRecord
  has_many :musics

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[musics]
  end
end
