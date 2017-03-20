class Team < ApplicationRecord
  has_many :players
  belongs_to :team_owner

  validates :name, presence: true, uniqueness: true

  #accepts_nested_attributes_for :players
end
