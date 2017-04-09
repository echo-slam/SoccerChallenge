class MatchRequestsController < ApplicationController
  def new
    @match_request = MatchRequest.new
  end

  def create
    @match = Match.find(params[:match_id])
    @match_request = MatchRequest.new
    @match_request.match_id = params[:match_id]
    @match_request.team_id = current_player.team_owner.team_id
    @match_request.team_received_id = @match.team_owner_id

    if @match_request.save
      flash[:success] = 'Request to match is sent'
      @match_request.create_join_invite_notify("join")
    else
      flash[:error] = @match_request.errors.full_messages.to_sentence
    end
    redirect_to matches_path
  end

  def invite
    if params[:match_id]
      @match = Match.find(params[:match_id])
      @match_invite = MatchRequest.new
      @match_invite.match_id = params[:match_id]
      @match_invite.team_id = @match.team_owner_id
      @match_invite.team_received_id = params[:team_id]
      @match_invite.status = 'INVITATION'

      if @match_invite.save
        flash[:success] = "Send invitation to #{Team.find(params[:team_id]).name}"
        @match_invite.create_join_invite_notify("invite")
      else
        flash[:error] = @match_invite.errors.full_messages.to_sentence
      end
      redirect_to waiting_match_path(@match)
    end
  end

  def accept
    if params[:match_id]
      @match_request = MatchRequest.find(params[:id])
      @match = Match.find(@match_request.match_id)
      @match.team_away_id = @match_request.team_id
      @match.is_start = true
      @match.save

      @match_request.create_accept_decline_notify("accept request")

      @match.match_requests.destroy_all
      flash[:success] = "Accept request from #{Team.find(@match.team_away_id).name}"
      redirect_to waiting_match_path(@match)
    else
      @match_invite = MatchRequest.find(params[:id])
      @match = Match.find(@match_invite.match_id)
      @match.team_away_id = @match_invite.team_received_id
      @match.is_start = true
      @match.save

      @match_invite.create_accept_decline_notify("accept invite")

      @match.match_requests.destroy_all
      flash[:success] = "Accept request from #{Team.find(@match.team_owner_id).name}"
      redirect_to waiting_match_path(@match)
    end
  end

  def destroy # for home team
    if params[:match_id]
      @match_request = MatchRequest.find(params[:id])
      flash[:notice] = "Decline match request from #{Team.find(@match_request.team_id).name}"
      @match_request.create_accept_decline_notify("decline request")
      @match_request.destroy
      redirect_to waiting_match_path(params[:match_id])
    elsif params[:team_id]
      @match_invite = MatchRequest.find(params[:id])
      @match = Match.find(@match_invite.match_id)
      flash[:notice] = "Cancel match invite to #{Team.find(@match_invite.team_received_id).name}"
      @match_invite.create_accept_decline_notify("cancel invite")
      @match_invite.destroy
      redirect_to waiting_match_path(@match.id)
    end
  end

  def decline # for away team
    if params[:match_id]
      @match_request = MatchRequest.find(params[:id])
      flash[:notice] = "Cancel match request to #{Team.find(@match_request.team_received_id).name}"
      @match_request.create_accept_decline_notify("cancel request")
      @match_request.destroy
    elsif params[:team_id]
      @match_invite = MatchRequest.find(params[:id])
      flash[:notice] = "Decline match invite from #{Team.find(@match_invite.team_id).name}"
      @match_invite.create_accept_decline_notify("decline invite")
      @match_invite.destroy
    end
    redirect_to matches_path
  end
end