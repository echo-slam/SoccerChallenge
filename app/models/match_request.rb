class MatchRequest < ApplicationRecord
  belongs_to :team
  belongs_to :match

  def create_join_invite_notify(type)
    if type == "join"
      r_sender_id = self.team_id
      r_recipient_id = self.team_received_id

    elsif type == "invite"
      r_sender_id = self.team_received_id
      r_recipient_id = self.team_id
    end
      
    create_notify(r_sender_id, r_recipient_id, type)
  end

  def create_accept_decline_notify(type)
    if type == "decline_invite" || type == "accept_invite"
      r_sender_id = self.team_id
      r_recipient_id = self.team_received_id

    else
      r_sender_id = self.team_received_id
      r_recipient_id = self.team_id
      
    end
    create_notify(r_sender_id, r_recipient_id, type)
  end


  def create_notify(sender_id, recipient_id, type)
    team_recipient = Team.find(recipient_id) 
    team_sender = Team.find(sender_id)

    notice_messages = "\
Team: #{team_sender.name} has sent #{type} request \
to your team(#{team_recipient.name})"

    Notification.create(
      notified_by_id: team_sender.team_owner_id,
      player_id: team_recipient.team_owner_id,
      match_id: self.match_id,
      team_id: nil,
      notice_type: 'match_request_' + type,
      notice_messages: notice_messages)
  end

end
