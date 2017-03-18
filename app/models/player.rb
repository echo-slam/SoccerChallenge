class Player < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true

  belongs_to :team
  has_one :team_owner
end
