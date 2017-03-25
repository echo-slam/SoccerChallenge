class Player < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :full_name, presence: true

  belongs_to :team, optional: true
  has_one :team_owner, dependent: :destroy

  mount_uploader :image_url, ImageUploader
  
  def to_s
    full_name
  end

  def self.search(search)
    where("full_name ILIKE ?", "%#{search}%")
  end

  def is_team_owner?
    self.team_owner.team_id != nil
  end

  def free_player?
    self.team_id == nil
  end
end
