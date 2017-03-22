class MatchRequestsController < ApplicationController

  def create
    # Join the match
    if params[:match_id]
      # Assume that the "join" button pass the params match_id when clicked
      @team = Team.find(current_player.team_owner.team_id)
      @match = Match.find(params[:match_id])
      @match_request = @team.match_requests.build
      
      @match_request.match_id = @match.id
      @match_request.requested_team_id = @match.team_owner_id
      
      if @match_request.save
        flash[:success] = "The request is saved"
      else
        flash[:error] = @match_request.errors_full_messages.to_sentence
      end
      redirect_to matches_path
      
    # Invite team to the match
    elsif params[:invite_id]
      # Assume that the "invite" button is in MATCH_PATH(:id)
      # The invite_id will be pass to this controller when clicked the invite btn
      @team = Team.find(current_player.team_owner.team_id)
      @match = Match.find(params[:id])
      @match_request = @team.match_requests.build
      
      @match_request.match_id = @match.id
      @match_request.requested_team_id = params[:invite_id]
      
      if @match_request.save
        flash[:success] = "The invitation is sent"
      else
        flash[:error] = @match_request.errors.full_messages.to_sentence
      end
      redirect_to match_path(@match)
    end
    
  end
end
