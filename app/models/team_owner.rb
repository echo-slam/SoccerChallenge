class TeamOwner < ApplicationRecord
  belongs_to :player
  has_one :team
end
