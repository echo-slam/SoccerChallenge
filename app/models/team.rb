class Team < ApplicationRecord
  has_many :players
  belongs_to :team_owner
end
