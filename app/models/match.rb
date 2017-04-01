class Match < ApplicationRecord
  has_many :match_requests
  has_many :match_messages, dependent: :destroy

  def captain_id
    Team.find(team_owner_id).team_owner.player_id
  end

  def venue_name
    Venue.find(venue_id).name
  end

  def field_name_or_default
    if field_id
      Field.find(field_id).name
    else
      'Unknown'
    end
  end

  def home_team_name
    Team.find(team_owner_id).name
  end

  def home_goal_or_default
    home_goal || ' '
  end

  def away_goal_or_default
    away_goal || ' '
  end

  def requests
    match_requests.where(status: 'PENDING')
  end

  def invitations
    match_requests.where(status: 'INVITATION')
  end

  def self.upcoming
    where("starts_at > ?", Time.now)
  end

  def self.not_ended
    where(is_end: nil)
  end
end
