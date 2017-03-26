class Match < ApplicationRecord
  has_many :match_requests
  has_many :match_messages, dependent: :destroy

  def venue_name
    Venue.find(venue_id).name
  end

  def field_name
    Field.find(field_id).name
  end

  def home_team_name
    Team.find(team_owner_id).name
  end

  def self.upcoming
    where("starts_at > ?", Time.now)
  end

  def self.not_started
    where(is_start: nil)
  end
end
