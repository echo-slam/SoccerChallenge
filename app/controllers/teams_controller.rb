class TeamsController < ApplicationController
  def new
    @team_owner = TeamOwner.find_by(:player_id => current_player.id)
    @team = @team_owner.build_team
  end

  def create
    @team_owner = TeamOwner.find_by(:player_id => current_player.id)
    @team = @team_owner.build_team(team_params)
    if @team.save?
      flash[:success] = "Successfully create team"
      redirect_to root_path
    else
      flash[:error] = @team.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
    def team_params
      params.require(:team).permit(:name)
    end
end
