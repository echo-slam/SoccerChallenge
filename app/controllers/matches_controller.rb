class MatchesController < ApplicationController
  before_action :set_team_owner, only: [:new, :create]

  def show
    set_match
  end

  def new
    @match = @team_owner.matches.build
  end

  def create
    @match = @team_owner.matches.build(match_params)
    if @match.save
      redirect_to root_path, flash: {success: 'Create match successfully'}
    else
      flash[:error] = @match.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
    def set_team_owner
      @team_owner = TeamOwner.find_by(player_id: current_player.id)
    end

    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(:team_owner_id, :team_away_id, :venue_id, :field_id, :starts_at, :ends_at, :is_start, :home_goal, :away_goal)
    end
end
