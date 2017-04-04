class TeamsController < ApplicationController
  before_action :set_team_owner, only: [:new, :create]

  def index
    @teams = Team.all.order(points: "DESC")
    @team_invites = TeamRequest.where(player_id: current_player.id).where(kind: "invite")
    @team_requests = TeamRequest.where(player_id: current_player.id).where(kind: "request")

    if params[:search]
      @teams = Team.search(params[:search]).order(points: "DESC")
    end
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
    @home_matches = Match.where(team_owner_id: @team.id).where(is_end: true)
    @away_matches = Match.where(team_away_id: @team.id).where(is_end: true)
    @games_played = @home_matches.count + @away_matches.count

    @home_goals = 0
    @home_loss_goals = 0
    if @home_matches.count > 0
      @home_matches.each do |match|
        @home_goals += match.home_goal
        @home_loss_goals += match.away_goal
      end
    end
    @away_goals = 0
    @away_loss_goals = 0
    if @away_matches.count > 0
      @away_matches.each do |match|
        @away_goals += match.away_goal
        @away_loss_goals += match.home_goal
      end
    end
    @goals = @home_goals + @away_goals
    @loss_goals = @home_loss_goals + @away_loss_goals

    @next_not_end_match = Match.where(is_start: true).where(is_end: nil)
    @next_home_match = @next_not_end_match.where(team_owner_id: @team.id).order(starts_at: "ASC").first
    @next_away_match = @next_not_end_match.where(team_away_id: @team.id).order(starts_at: "ASC").first

    if @next_home_match
      if @next_away_match
        if @next_home_match.starts_at < @next_away_match.starts_at
          @upcoming_match = @next_home_match
        else
          @upcoming_match = @next_away_match
        end
      else
        @upcoming_match = @next_home_match
      end
    else
      @upcoming_match = @next_away_match
    end

    if @upcoming_match
      if @upcoming_match.team_away_id == @team.id
        @team_is_home = false
        @remain_team = Team.where(id: @upcoming_match.team_owner_id).first
      else
        @team_is_home = true
        @remain_team = Team.where(id: @upcoming_match.team_away_id).first
      end
    end

    @team_invites = TeamRequest.where(player_id: current_player.id).where(kind: "invite")
    @team_requests = TeamRequest.where(player_id: current_player.id).where(kind: "request")
    @match_invites = MatchRequest.where(team_id: @team.id).where(status: 'INVITATION')

    if @match_invites.count > 0
      @match_invite_string = "#{@match_invites.count} Match Invitations"
    else
      @match_invite_string = "Match Invitation"
    end

    @world_messages = WorldMessage.order(created_at: "DESC").first(100)
    @channel = "world"

    if params[:channel] == "world"
      @channel = "world"
    elsif params[:channel] == "team"
      @channel = "team"
    end

    @recent_matches = Match.where("team_owner_id = ? OR team_away_id = ?", @team.id, @team.id).where(is_end: true).order(starts_at: 'ASC').first(5)

    @win_matches = MatchResult.where(win_team_id: @team.id)
    if @games_played > 0
      @win_rate = (@win_matches.count * 100) / @games_played
    else
      @win_rate = 0
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
