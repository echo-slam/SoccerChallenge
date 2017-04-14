class TeamRequest < ApplicationRecord
  belongs_to :player
  belongs_to :team

  def create_join_invite_notify()
    if self.kind == "invite"
      player_recipient = Player.find(self.player_id)
      team_sender = Team.find(self.team_id)
      notice_messages = "\
Team: #{team_sender.name} has sent #{self.kind} request <br>\
to you"
      
      create_notify(team_sender.team_owner_id, 
        player_recipient.id,
        notice_messages,
        team_sender.image_url_or_default,
        self.kind)
    else
      team_recipient = Team.find(self.team_id)
      player_sender = Player.find(self.player_id)

      notice_messages = "\
Player: #{player_sender.full_name} has sent #{self.kind} request <br>\
to your team"

      create_notify(player_sender.id,
        team_recipient.team_owner_id,
        notice_messages,
        player_sender.image_url_or_default,
        self.kind)
    end

  end

  def self.create_accept_notify(team_id, player_id, type)
    @team = Team.find(team_id)
    @player = Player.find(player_id)

    if type == "accept_invite"
      notice_messages = "\
Player: #{@player.full_name} has accepted <br>\
your invitation to join your team"

      sub_create_notify(player_id, @team.team_owner_id,
        team_id, notice_messages, 
        @player.image_url_or_default, type)
    else

      notice_messages = "\
Team: #{@team.name} has accepted <br>\
your request to join their team"

      sub_create_notify(@team.team_owner_id, player_id,
        team_id, notice_messages, 
        @team.image_url_or_default, type)
    end
  end

  def self.create_decline_notify(team_id, player_id, type)
    @team = Team.find(team_id)
    @player = Player.find(player_id)
    if type == "decline_request"
      notice_messages = "\
Team: #{@team.name} has declined <br>\
your request to join their team"
      sub_create_notify(@team.team_owner_id, player_id,
        team_id, notice_messages, 
        @team.image_url_or_default, type)

    else
      notice_messages = "\
Player: #{@player.full_name} has declined <br>\
your invitation to join your team"
      sub_create_notify(player_id, @team.team_owner_id,
        team_id, notice_messages, 
        @player.image_url_or_default, type)

    end

  end

  def self.sub_create_notify (sender_id, recipient_id, 
    team_id, notice_messages, image_url, type)
    Notification.create(
      notified_by_id: sender_id,
      player_id: recipient_id,
      match_id: nil,
      team_id: team_id,
      image_url: image_url,
      notice_type: 'team_request_' + type,
      notice_messages: notice_messages)

  end

  def create_notify(sender_id, recipient_id, notice_messages, image_url, type)
    Notification.create(
      notified_by_id: sender_id,
      player_id: recipient_id,
      match_id: nil,
      team_id: self.team_id,
      image_url: image_url,
      notice_type: 'team_request_' + type,
      notice_messages: notice_messages)
  end
end
