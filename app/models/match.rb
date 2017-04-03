class Match < ApplicationRecord
  has_many :match_requests
  has_many :match_messages, dependent: :destroy
  has_one :match_result

  validates_uniqueness_of :starts_at, scope: :field_id

  def captain_id
    Team.find(team_owner_id).team_owner.player_id
  end

  def venue_name
    Venue.find(venue_id).name
  end

  def field_name_or_default
    field_id ? Field.find(field_id).name : 'Unknown'
  end

  def ends_at_or_default
    ends_at.presence || starts_at
  end

  def home_team_name
    Team.find(team_owner_id).name
  end

  def away_team_name
    Team.find(team_away_id).name
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
