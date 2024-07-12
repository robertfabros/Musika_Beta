# app/models/page.rb
class Page < ApplicationRecord
  before_save :generate_slug

  validates :title, presence: true
  validates :content, presence: true

  def to_param
    slug
  end

  def self.find_by_slug(slug)
    find_by(slug: slug)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[content created_at id slug title updated_at]
  end

  private

  def generate_slug
    self.slug = title.parameterize if slug.blank?
  end
end
