class TeamOwner < ApplicationRecord
  belongs_to :player
  has_one :team
  has_many :matches, dependent: :destroy
end
