class Match < ApplicationRecord
  has_many :match_requests

  def venue_name
    Venue.find(venue_id).name
  end

  def home_team_name
    Team.find(team_owner_id).name
  end

  def self.upcoming
    where("starts_at > ?", Time.now)
  end
end
