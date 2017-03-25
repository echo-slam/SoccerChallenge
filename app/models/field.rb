class Field < ApplicationRecord
  belongs_to :field_owner
  belongs_to :venue
  mount_uploader :image_url, ImageUploader

  validates :name, presence: true, uniqueness: true
  validates_processing_of :image_url
  validate :image_size_validation
  
  private
    def image_size_validation
      errors[:image_url] << "should be less than 500KB" if image_url.size > 0.5.megabytes
    end
end
