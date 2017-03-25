class Team < ApplicationRecord
  belongs_to :team_owner
  has_many :players
  has_many :match_requests
  has_many :matches, through: :match_requests
  has_many :team_messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  mount_uploader :image_url, ImageUploader
  
  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
