class FieldOwner < ApplicationRecord
  has_secure_password

  has_many :fields 

  validates :email, uniqueness: true

end
