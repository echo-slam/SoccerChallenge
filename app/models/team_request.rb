class TeamRequest < ApplicationRecord
  belongs_to :player
  belongs_to :team

  def create_join_invite_notify()
    if self.kind == "invite"
      player_recipient = Player.find(self.player_id)
      team_sender = Team.find(self.team_id)
      notice_messages = "\
Team: #{team_sender.name} has sent #{self.kind} request \
to you(#{player_recipient.full_name})"
      
      create_notify(team_sender.team_owner_id, 
        player_recipient.id,
        notice_messages,
        self.kind)
    else
      team_recipient = Team.find(self.team_id)
      player_sender = Player.find(self.player_id)

      notice_messages = "\
Player: #{player_sender.full_name} has sent #{self.kind} request \
to your team (#{team_recipient.name})"

      create_notify(player_sender.id,
        team_recipient.team_owner_id,
        notice_messages,
        self.kind)
    end

  end

  def self.create_accept_notify(team_id, player_id, type)
    @team = Team.find(team_id)
    @player = Player.find(player_id)

    if type == "accept_invite"
      notice_messages = "\
Player: #{@player.full_name} has accepted \
your invitation to join your team(#{@team.name})"

      sub_create_notify(player_id, @team.team_owner_id,
        team_id, notice_messages, type)
    else

      notice_messages = "\
Team: #{@team.name} has accepted \
your request(#{@player.full_name}) to join their team"

      sub_create_notify(@team.team_owner_id, player_id,
        team_id, notice_messages, type)
    end
  end

  def self.create_decline_notify(team_id, player_id, type)
    @team = Team.find(team_id)
    @player = Player.find(player_id)
    if type == "decline_request"
      notice_messages = "\
Team: #{@team.name} has declined \
your request(#{@player.full_name}) to join their team"
      sub_create_notify(@team.team_owner_id, player_id,
        team_id, notice_messages, type)

    else
      notice_messages = "\
Player: #{@player.full_name} has declined \
your invitation to join your team (#{@team.name})"
      sub_create_notify(player_id, @team.team_owner_id,
        team_id, notice_messages, type)

    end

  end

  def self.sub_create_notify (sender_id, recipient_id, 
    team_id, notice_messages, type)
    Notification.create(
      notified_by_id: sender_id,
      player_id: recipient_id,
      match_id: nil,
      team_id: team_id,
      notice_type: 'team_request_' + type,
      notice_messages: notice_messages)

  end

  def create_notify(sender_id, recipient_id, notice_messages, type)
    Notification.create(
      notified_by_id: sender_id,
      player_id: recipient_id,
      match_id: nil,
      team_id: self.team_id,
      notice_type: 'team_request_' + type,
      notice_messages: notice_messages)
  end
end
