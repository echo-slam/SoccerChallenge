class Field < ApplicationRecord
  belongs_to :field_owner
  belongs_to :venue

  mount_uploader :image_url, ImageUploader
  
end
