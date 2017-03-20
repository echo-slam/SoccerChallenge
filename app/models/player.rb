class Player < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :full_name, presence: true

  belongs_to :team, optional: true
  has_one :team_owner

end
