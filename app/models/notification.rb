class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'Player'
  belongs_to :player

  def return_path
    if match_id.nil?
      case notice_type
        when "team_request_invite"
          return "/teams"
        
        when "team_request_request"
          return "/players"

        when "team_request_accept_request"
          return "/teams/#{self.team_id}"

        when "team_request_accept_invite"
          return "/teams/#{self.team_id}"

        when "team_request_decline_invite"
          return "/teams"

        when "team_request_decline_request"
          return "/teams"
      end
    else
      case notice_type
        when "match_request_accept_request", "match_request_accept_invite"
          return "/matches/#{self.match_id}/waiting"

        else
          return "/matches" 
      end
    end

  end
end
