class Player < ApplicationRecord
  has_secure_password
  belongs_to :team, optional: true
  has_one :team_owner, dependent: :destroy
  mount_uploader :image_url, ImageUploader
  
  has_many :notifications, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :player_results

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates_processing_of :image_url
  validate :image_size_validation

  def notify_messages
    Notification.where(player_id: self.id)
  end
  
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

  def image_url_or_default
    self.image_url.url.presence || "http://i.imgur.com/WbCAvCJ.png"
  end

  def self.from_omniauth(auth)
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    full_name = auth[:info][:name] || "Username"
    player = where(email: email).first_or_initialize

    player.full_name = full_name
    player.email = email
    player.password = SecureRandom.base64(10)

    player.save! && player
  end

  private
    def image_size_validation
      errors[:image_url] << "should be less than 500KB" if image_url.size > 0.5.megabytes
    end
end
