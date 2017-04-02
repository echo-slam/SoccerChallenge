class FieldOwner < ApplicationRecord
  has_secure_password
  has_many :fields
  mount_uploader :image_url, ImageUploader

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates_processing_of :image_url
  validate :image_size_validation

  def to_s
    full_name
  end

  def image_url_or_default
    image_url.url.presence || 'http://i.imgur.com/rWrONuem.jpg'
  end

  private
    def image_size_validation
      errors[:image_url] << "should be less than 500KB" if image_url.size > 0.5.megabytes
    end
end
