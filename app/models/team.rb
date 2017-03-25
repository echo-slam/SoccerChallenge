class Team < ApplicationRecord
  belongs_to :team_owner
  has_many :players
  has_many :match_requests
  has_many :matches, through: :match_requests
  has_many :team_messages, dependent: :destroy
  mount_uploader :image_url, ImageUploader
  
  validates :name, presence: true, uniqueness: true
  validates_processing_of :image_url
  validate :image_size_validation
  
  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end

  private
    def image_size_validation
      errors[:image_url] << "should be less than 500KB" if image_url.size > 0.5.megabytes
    end
end
