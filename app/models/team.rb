class Team < ApplicationRecord
  belongs_to :team_owner
  has_many :players
  has_many :match_requests
  has_many :matches, through: :match_requests

  validates :name, presence: true, uniqueness: true

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
