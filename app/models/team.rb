class Team < ApplicationRecord
  has_many :players
  belongs_to :team_owner

  validates :name, presence: true, uniqueness: true

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
