class MatchRequestsController < ApplicationController
  before_action :set_match_request, only:[:accept, :decline]

  def join
    @team_request = Team.find(current_player.team_owner.team_id)
    @match = Match.find(params[:match_id])
    @match_request = @team_request.match_requests.build
    @match_request.match_id = params[:match_id]
    @match_request.team_received_id = @match.team_owner_id

    if @match_request.save
      flash[:success] = 'Request is sent'
    else
      flash[:error] = @match_request.errors.full_messages.to_sentence
    end
    redirect_to matches_path
  end

  def invite
    if params[:match_id]
      @team_away = Team.find(params[:team_id])
      @match = Match.find(params[:match_id])
      @match_invite = @team_away.match_requests.build
      @match_invite.match_id = params[:match_id]
      @match_invite.team_received_id = @match.team_owner_id
      @match_invite.status = 'INVITATION'

      if @match_invite.save
        flash[:success] = 'Send invitation'
      else
        flash[:error] = @match_invite.errors.full_messages.to_sentence
      end
      redirect_to waiting_match_path(@match)
    end
  end

  def accept
    @match_request.status = 'ACCEPTED'
    if params[:match_id]
      if @match_request.save
        @match.team_away_id = @match_request.team_id
        @match.is_start = true
        @match.save
        flash[:success] = "Accept request from #{Team.find(@match.team_away_id).name}"
      else
        flash[:error] = 'Error happen when accept a request'
      end
      redirect_to waiting_match_path(params[:match_id])
    else # accept invite
      if @match_request.save
        @match.team_away_id = @match_request.team_id
        @match.is_start = true
        @match.save
        flash[:success] = "Accept request from #{Team.find(@match_request.team_received_id).name}"
      else
        flash[:error] = 'Error happen when accept a request'
      end
      redirect_to waiting_match_path(@match_request.match_id)
    end
  end

  def decline
    @match_request.destroy
    if params[:match_id]
      flash[:notice] = "Decline request"
      redirect_to waiting_match_path(params[:match_id])
    else # decline invite
      flash[:notice] = "Decline invite"
      redirect_to matches_path
    end
  end

  private
    def set_match_request
      @match_request = MatchRequest.find(params[:id])
      @match = Match.find(@match_request.match_id)
    end
end
