class Team < ApplicationRecord
  has_many :players
  belongs_to :team_owner

  #accepts_nested_attributes_for :players
end
