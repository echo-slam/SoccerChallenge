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
    
  end

  def accept
    @match = Match.find(params[:match_id])
    @match_request.status = 'ACCEPTED'
    if @match_request.save
      @match.team_away_id = @match_request.team_id
      @match.is_start = true
      @match.save
      flash[:success] = "Accept request from #{Team.find(@match.team_away_id).name}"
    else
      flash[:error] = 'Error happen when accept a request'
    end
    redirect_to waiting_match_path(params[:match_id])
  end

  def decline
    @match_request.destroy
    flash[:notice] = "Decline request"
    redirect_to waiting_match_path(params[:match_id])
  end

  private
    def set_match_request
      @match_request = MatchRequest.find(params[:id])
    end
end
