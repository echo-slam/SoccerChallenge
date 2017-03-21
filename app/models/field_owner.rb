class FieldOwner < ApplicationRecord
  has_secure_password

  has_many :fields 

  validates :email, uniqueness: true
  validates :full_name, presence: true

end
