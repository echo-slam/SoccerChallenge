class MatchRequest < ApplicationRecord
  belongs_to :team
  belongs_to :match

  def create_join_invite_notify(type)
    if type == "join"
      r_sender_id = self.team_id
      r_recipient_id = self.team_received_id

    elsif type == "invite"
      r_sender_id = self.team_id
      r_recipient_id = self.team_received_id
    end
    
    create_notify(r_sender_id, r_recipient_id, type)
  end

  def create_accept_decline_notify(type)
    if type == "cancel_invite" || type == "cancel_request"
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
    case type
      when "invite"
        notice_messages = "#{team_sender.name} invites your team <br>\
        to join their match"

      when "join"
        notice_messages = "#{team_sender.name} wants to join your match"

      when "cancel_invite"
        notice_messages = "#{team_sender.name} cancels match invitation"

      when "cancel_request"
        notice_messages = "#{team_sender.name} cancels match request"

      when "accept_invite"
        notice_messages = "#{team_sender.name} accepts your match invitation"
      
      when "accept_request"
        notice_messages = "#{team_sender.name} accepts your match request"
      
      when "decline_request"
        notice_messages = "#{team_sender.name} rejects your match request"
        
      when "decline_invite"
        notice_messages = "#{team_sender.name} rejects your match invitation"
    end

    Notification.create(
      notified_by_id: team_sender.team_owner_id,
      player_id: team_recipient.team_owner_id,
      match_id: self.match_id,
      team_id: nil,
      image_url: team_sender.image_url_or_default,
      notice_type: 'match_request_' + type,
      notice_messages: notice_messages)
  end

end
