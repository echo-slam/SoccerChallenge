class MatchRequestsController < ApplicationController
  def create
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
end
