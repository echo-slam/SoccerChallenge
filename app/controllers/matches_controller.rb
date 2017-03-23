class MatchesController < ApplicationController
  before_action :set_match, only: [:show,:update]

  def index
    @matches = Match.upcoming.not_started
  end

  def show
    @home_team_players = Player.where(team_id: @match.team_owner_id)
    @away_team_players = Player.where(team_id: @match.team_away_id)
    @pending_requests = MatchRequest.where(team_received_id: @match.team_owner_id).where(status: 'PENDING')

    if params[:status]
      @match_request = MatchRequest.find(params[:request_id])
      @match_request.status = params[:status]
      @match_request.save
      if params[:status] = 'ACCEPT'
        @match.team_away_id = @match_request.team_id
        @match.is_start = true
        @match.save
      end
      render 'show'
    end
  end

  def new
    @match = Match.new
  end

  def update
    @home_team_players = Player.where(team_id: @match.team_owner_id)
    respond_to do |format|
      if @match.update(match_params)
        format.html { render :show, info: 'Match was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end

  def create
    @match = Match.new match_params
    @match.team_owner_id = current_player.team_id
    if @match.save
      redirect_to match_path(@match), flash: {success: 'Create match successfully'}
    else
      flash[:error] = @match.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(:team_owner_id, :team_away_id, :venue_id, :field_id, :starts_at, :ends_at, :is_start, :home_goal, :away_goal)
    end
end
