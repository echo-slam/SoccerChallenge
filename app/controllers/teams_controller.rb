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
    @top_scorers = @players.order(goal: "ASC").first(5)

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
    @goals_dif = @goals - @loss_goals

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
    @channel = "team"

    if params[:channel] == "world"
      @channel = "world"
    elsif params[:channel] == "team"
      @channel = "team"
    end

    @recent_matches = Match.where("team_owner_id = ? OR team_away_id = ?", @team.id, @team.id).where(is_end: true).order(starts_at: 'DESC').first(5)

    @num_win_matches = MatchResult.where(win_team_id: @team.id).count
    @num_loss_matches = MatchResult.where(loss_team_id: @team.id).count
    @num_draw_matches = @games_played - @num_win_matches - @num_loss_matches

    @team_results = {
                      "Win" => @num_win_matches,
                      "Loss" => @num_loss_matches,
                      "Draw" => @num_draw_matches
                    }

    @team_goals = { "GF" => @goals,
                    "GA" => @loss_goals
                  }

    @top_scorers_data = ([
                            [@top_scorers[0].full_name, @top_scorers[0].goal],
                            [@top_scorers[1].full_name, @top_scorers[1].goal],
                            [@top_scorers[2].full_name, @top_scorers[2].goal],
                            [@top_scorers[3].full_name, @top_scorers[3].goal],
                            [@top_scorers[4].full_name, @top_scorers[4].goal]
                        ])

    @library_result = {
      series: {
        name: 'Matches'
      },
      title: {
        text: "#{@games_played} Matches",
        align: 'center',
        verticalAlign: 'middle',
        style: {
            fontWeight: 'bold',
            color: "#32373A",
            fontName: "Lato",
            fontSize: 15
        }
      },
      plotOptions: {
        pie: {
            shadow: false,
            center: ['50%', '50%'],
            innerSize: '70%',
        },
        dataLabels: {
          format: "{x}"
        }
      },
      colors: ['#36B8B2', '#EA5455', '#FFD460'],
      legend: false
    }

    @library_goal = {
      title: {
        text: "#{@goals_dif} GD",
        align: 'center',
        verticalAlign: 'middle',
        style: {
            fontWeight: 'bold',
            color: "#32373A",
            fontName: "Lato",
            fontSize: 15
        }
      },
      plotOptions: {
        pie: {
            shadow: false,
            center: ['50%', '50%'],
            innerSize: '70%',
        },
        dataLabels: {
          format: "{x}"
        }
      },
      colors: ['#36B8B2', '#EA5455', '#FFD460'],
      legend: false
    }

    @library_top_scorers = {
      legend: false,
      colors: ['#36B8B2', '#36B8B2']
    }

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
