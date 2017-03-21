class MatchRequestsController < ApplicationController

  def create
    if params[:match_id]
      @team = Team.find_by_id(current_player.team_owner.team_id)
      @match = Match.find_by_id(params[:match_id])
      @match_request = @team.match_requests.build
      
      @match_request.match_id = params[:match_id]
      @match_request.requested_team_id = @match.team_owner_id
      
      if @match_request.save
        flash[:success] = "The request is saved"
      else
        flash[:error] = @match_request.errors_full_messages.to_sentence
      end
      redirect_to matches_path
    end
  end
end
