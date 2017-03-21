class Match < ApplicationRecord
  belongs_to :field
  
  def self.update_match_data(req_id)
    m_request = MatchRequest.find_by_id(req_id)
    m = Match.find_by_id(m_request.match_id)
    if m_request.status == "ACCEPT"
      m.team_away_id = m_request.team_request_id
      m.save
    end
  end
  
  def self.upcoming
    where("starts_at > ?", Time.now)
  end
  
end
