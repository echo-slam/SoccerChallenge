class Match < ApplicationRecord
  def venue_name
    Venue.find(venue_id).name
  end

  def home_team_name
    Team.find(team_owner_id).name
  end
end
