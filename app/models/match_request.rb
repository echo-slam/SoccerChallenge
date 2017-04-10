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
    if type == "cancel_invite" || type == "accept_invite"
      r_sender_id = self.team_received_id
      r_recipient_id = self.team_id

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
        notice_messages = "\
#{team_sender.name} has invited your team <br>\
to join their match"

      when "join"
        notice_messages = "\
#{team_sender.name} has joined your match"

      when "cancel_invite"
        notice_messages = "\
#{team_sender.name} has declined your invitation <br>\
to join your match"

      when "accept_invite"
        notice_messages = "\
#{team_sender.name} has accepted your invitation <br>\
to join your match"
      
      when "accept_request"
        notice_messages = "\
#{team_sender.name} has accepted your request <br>\
to join their match"
      
      when "decline_request"
        notice_messages = "\
#{team_sender.name} has rejected your team <br>\
to join their match"
        
      when "decline_invite"
        notice_messages = "\
#{team_sender.name} has rejected your invitation <br>\
to join your match"
    end

    Notification.create(
      notified_by_id: team_sender.team_owner_id,
      player_id: team_recipient.team_owner_id,
      match_id: self.match_id,
      team_id: nil,
      notice_type: 'match_request_' + type,
      notice_messages: notice_messages)
  end

end
