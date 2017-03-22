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
    if params[:status]
      MatchRequest.update_request_status(params[:r_id], params[:status])
      Match.update_match_data(params[:r_id])
    end
    @team = Team.find_by(:id => params[:id])
    @pending_requests = MatchRequest.where({:requested_team_id => @team.id, :status => "PENDING"})
  end

  private
    def set_team_owner
      @team_owner = TeamOwner.find_by(player_id: current_player.id)
    end

    def team_params
      params.require(:team).permit(:name)
    end
end
