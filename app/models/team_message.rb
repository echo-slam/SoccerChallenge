class TeamMessage < ApplicationRecord
  belongs_to :team
  validates :body, presence: true
end
