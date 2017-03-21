class MatchRequest < ApplicationRecord
  belongs_to :team
  
  def self.update_request_status(id, status)
    m_request = MatchRequest.find_by_id(id)
    m_request.status = status
    m_request.save
  end
end
