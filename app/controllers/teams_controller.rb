class TeamsController < ApplicationController
  before_action :set_team_owner, only: [:new, :create]

  def new
    @player = current_player
    @team = @team_owner.build_team
  end

  def create
    @player = current_player
    @team = @team_owner.build_team(team_params)
    if @team.save
      @team_owner.team_id = @team.id
      @player.team_id = @team.id
      @team_owner.save
      @player.save
      flash[:success] = "Successfully create team"
      redirect_to root_path
    else
      flash[:error] = @team.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.players
    @team_owner = TeamOwner.find(@team.team_owner_id)
    @home_matches = Match.where(team_owner_id: @team_owner.id)
    @away_matches = Match.where(team_away_id: @team.id)
    @number_of_matches = (@home_matches.count + @away_matches.count) || 0
  end

  private
    def set_team_owner
      @team_owner = TeamOwner.find_by(player_id: current_player.id)
    end

    def team_params
      params.require(:team).permit(:name)
    end
end
