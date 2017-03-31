class TeamsController < ApplicationController
  before_action :set_team_owner, only: [:new, :create]

  def index
    @teams = Team.all.order("name DESC")
    @team_invites = TeamRequest.where(player_id: current_player.id).where(kind: "invite")
    @team_requests = TeamRequest.where(player_id: current_player.id).where(kind: "request")

    if params[:search]
      @teams = Team.search(params[:search]).order("name DESC")
    end
  end

  def away
    @away_team = Team.find(params[:id])
  end

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
    @team_messages = @team.team_messages.order(created_at: "DESC").first(50)

    @players = @team.players
    @first_five_players = @team.players.first(5)

    @player_requests = TeamRequest.where(team_id: @team.id).where(kind: "request")

    if @player_requests.count > 0
      @team_request_string = "#{@player_requests.count} Team Requests"
    else
      @team_request_string = "Team Request"
    end

    @team_owner = TeamOwner.find(@team.team_owner_id)
    @home_matches = Match.where(team_owner_id: @team_owner.id).where(is_end: true)
    @away_matches = Match.where(team_away_id: @team.id).where(is_end: true)
    @games_played = (@home_matches.count + @away_matches.count) || 0

    @match_invites = MatchRequest.where(team_id: @team.id).where(status: 'INVITATION')

    if @match_invites.count > 0
      @match_invite_string = "#{@match_invites.count} Match Invitations"
    else
      @match_invite_string = "Match Invitation"
    end
  end

  def team_members
    @team = Team.find(params[:id])
    @players = @team.players
  end

  private
    def set_team_owner
      @team_owner = TeamOwner.find_by(player_id: current_player.id)
    end

    def team_params
      params.require(:team).permit(:name, :image_url)
    end
end
