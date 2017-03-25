class FieldOwner < ApplicationRecord
  has_secure_password

  mount_uploader :image_url, ImageUploader
  
  has_many :fields 

  validates :email, uniqueness: true
  validates :full_name, presence: true

  def to_s
    full_name
  end

end
