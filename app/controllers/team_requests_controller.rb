class TeamRequestsController < ApplicationController
  def new
    @team_request = TeamRequest.new
  end

  def create
    if params[:team_id]
      @team_request = TeamRequest.new
      @team_request.player_id = current_player.id
      @team_request.team_id = params[:team_id]
      @team_request.kind = "request"

      if @team_request.save
        flash[:info] = "Request to join #{Team.find(params[:team_id]).name} has been sent"
        redirect_to teams_path
      else
        flash[:error] = "Unable to send team request"
        redirect_to teams_path
      end
    elsif params[:player_id]
      @team_request = TeamRequest.new
      @team_request.player_id = params[:player_id]
      @team_request.team_id = current_player.team_id
      @team_request.kind = "invite"

      if @team_request.save
        flash[:info] = "Player #{Player.find(params[:player_id]).full_name} is invited to join your team"
        redirect_to players_path
      else
        flash[:error] = "Unable to invite player"
        redirect_to players_path
      end
    end

    @team_request.create_join_invite_notify
  end

  def destroy
    if params[:team_id]
      @team_request = TeamRequest.where(team_id: params[:team_id]).first
      @team_request.destroy

      flash[:info] = "Cancel request to join team #{Team.find(params[:team_id]).name}"
      redirect_to teams_path
    elsif params[:player_id]
      @team_request = TeamRequest.where(player_id: params[:player_id]).first
      @team_request.destroy

      flash[:info] = "Cancel invitation to player #{Player.find(params[:player_id]).full_name}"
      redirect_to players_path
    end
  end

  def accept
    if params[:team_id]
      @player = current_player
      @player.team_id = params[:team_id]
      @player.save

      TeamRequest.create_accept_notify(
        team_id = params[:team_id],
        player_id = @player.id,
        type = "accept_invite"
      )

      @team_requests = TeamRequest.where(player_id: @player.id)
      @team_requests.each do |team_request|
        team_request.destroy
      end

      flash[:success] = "Join team #{@player.team.name} successfully"
      redirect_to team_path(params[:team_id])
    elsif params[:player_id]
      @player = Player.find(params[:player_id])
      @player.team_id = current_player.team_id
      @player.save

      TeamRequest.create_accept_notify(
        team_id = @player.team_id,
        player_id = @player.id,
        type = "accept_request"
      )

      @team_requests = TeamRequest.where(player_id: params[:player_id])
      @team_requests.each do |team_request|
        team_request.destroy
      end

      flash[:success] = "Accept player #{@player.full_name} to join your team"
      redirect_to team_path(current_player.team_id)
    end
  end

  def decline
    if params[:team_id]
      @team_request = TeamRequest.where(team_id: params[:team_id]).first
      @team_request.destroy

      TeamRequest.create_decline_notify(
        team_id = params[:team_id],
        player_id = current_player.id,
        type = "decline_invite"
      )

      flash[:notice] = "Refuse to join team #{Team.find(params[:team_id]).name}"
      redirect_to player_path(current_player.id)
    elsif params[:player_id]
      @team_request = TeamRequest.where(player_id: params[:player_id]).first
      @team_request.destroy

      TeamRequest.create_decline_notify(
        team_id = current_player.team_id,
        player_id = params[:player_id],
        type = "decline_request"
      )

      flash[:notice] = "Refuse player #{Player.find(params[:player_id]).full_name} to join your team"
      redirect_to team_path(current_player.team_id)
    end
  end
end
