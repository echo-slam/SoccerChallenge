class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :waiting, :away, :select, :edit, :update]
  before_action :check_match_permission, only: [:new]

  def index
    @matches = Match.upcoming.not_ended
  end

  def show

  end

  def new
    @match = Match.new
  end

  def waiting
    @pending_requests = MatchRequest.where(team_received_id: @match.team_owner_id).where(status: 'PENDING')
    @team_requested_ids = @match.match_requests.select(:team_id)
    @available_teams = Team.where.not(id: @match.team_owner_id).where.not(id: @team_requested_ids).where.not(id: @match.team_away_id)
    @match_messages = @match.match_messages.order(created_at: "DESC").first(50)
  end

  def away
    
  end

  def select
    @matches = Match.upcoming.not_ended.where(venue_id: @match.venue_id)
  end

  def edit
    
  end

  def create
    @match = Match.new match_params
    @match.team_owner_id = current_player.team_id
    if @match.save
      redirect_to waiting_match_path(@match), flash: {success: 'Create match successfully'}
    else
      flash[:error] = @match.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @match.update(match_params)
      if @match.home_goal and @match.away_goal
        @match.is_end = true
        @match.save
      end
      redirect_to match_path(@match), flash: { info: 'Match was successfully updated.' }
    else
      flash[:error] = @match.errors.full_messages.to_sentence
      render 'select'
    end
  end

  private
    def set_match
      @match = Match.find(params[:id])
      @home_team = Team.find(@match.team_owner_id)
      @home_team_players = @home_team.players.first(5)
      if @match.team_away_id
        @away_team = Team.find(@match.team_away_id)
        @away_team_players = @away_team.players.first(5)
      end
    end

    def match_params
      params.require(:match).permit(:team_owner_id, :team_away_id, :venue_id, :field_id, :starts_at, :ends_at, :is_start, :home_goal, :away_goal, :is_end)
    end
end
