class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :waiting, :away, :select, :edit, :update]
  before_action :set_admin, only: [:show, :edit, :update]
  before_action :check_match_permission, only: [:new]

  def index
    @matches = Match.order(is_start: 'DESC').order(starts_at: 'ASC')
    @match_invitations = MatchRequest.where(team_id: current_player.team_id).where(status: 'INVITATION')
    @match_requests = MatchRequest.where(team_id: current_player.team_id).where(status: 'PENDING')

    @top_10_teams = Team.order(points: 'DESC').first(10)

    case params[:sort]
    when 'mine'
      @matches = Match.where(team_owner_id: current_player.team_id).order(is_start: 'DESC')
    when 'waiting'
      @matches = Match.where(is_start: nil).order(starts_at: 'ASC')
    when 'completed'
      @matches = Match.where.not(is_end: nil).order(starts_at: 'DESC')
    when 'verify'
      @matches = Match.where.not(is_end: nil).order(starts_at: 'DESC')
    end
  end

  def show
    @is_host_or_admin = false
    if (current_player == @home_team_owner) or (current_player.email == "admin@soccerchallenge.com")
      @is_host_or_admin = true
    end

    @played_this_match = false
    if (current_player.team_id == @match.team_owner_id) or (current_player.team_id == @match.team_away_id)
      @played_this_match = true
    end

    @player_result = PlayerResult.where(match_id: @match.id).where(player_id: current_player.id).first
  end

  def new
    @match = Match.new
  end

  def waiting
    @pending_requests = MatchRequest.where(team_received_id: @match.team_owner_id).where(status: 'PENDING')
    @team_requested_ids = @match.match_requests.select(:team_id)
    @match_messages = @match.match_messages.order(created_at: "DESC").first(50)

    if params[:search]
      @available_teams = Team.search(params[:search]).where.not(id: @match.team_owner_id).where.not(id: @match.team_away_id).where.not(id: @team_requested_ids)
    else
      @available_teams = Team.where.not(id: @match.team_owner_id).where.not(id: @match.team_away_id).where.not(id: @team_requested_ids)
    end
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
        @match.save
      end
      if current_player.email == "admin@soccerchallenge.com"
        @match.is_end = true
        @match.save

        @match_result = MatchResult.where(match_id: @match.id).first
        if @match_result == nil
          @match_result = MatchResult.new(match_id: @match.id)
        end

        if @match.home_goal > @match.away_goal
          @match_result.win_team_id = @match.team_owner_id
          @match_result.loss_team_id = @match.team_away_id

          @win_players = Player.where(team_id: @match.team_owner_id)
          @loss_players = Player.where(team_id: @match.team_away_id)
        elsif @match.home_goal < @match.away_goal
          @match_result.win_team_id = @match.team_away_id
          @match_result.loss_team_id = @match.team_owner_id

          @win_players = Player.where(team_id: @match.team_away_id)
          @loss_players = Player.where(team_id: @match.team_owner_id)
        end

        if @match.home_goal == @match.away_goal
          @draw_players_one = Player.where(team_id: @match.team_away_id)
          @draw_players_two = Player.where(team_id: @match.team_owner_id)

          @draw_players_one.each do |player|
            if player.draw
              player.draw += 1
            else
              player.draw = 1
            end

            player.save
          end

          @draw_players_two.each do |player|
            if player.draw
              player.draw += 1
            else
              player.draw = 1
            end

            player.save
          end
        else
          @win_players.each do |player|
            if player.win
              player.win += 1
            else
              player.win = 1
            end

            player.save
          end

          @loss_players.each do |player|
            if player.loss
              player.loss += 1
            else
              player.loss = 1
            end

            player.save
          end
        end
        
        @match_result.save

        @home_team = Team.find(@match.team_owner_id)
        @home_win_matches = MatchResult.where(win_team_id: @home_team.id)
        @home_loss_matches = MatchResult.where(loss_team_id: @home_team.id)
        @home_team.points = 1000 + 25 * @home_win_matches.count - 25 * @home_loss_matches.count

        @away_team = Team.find(@match.team_away_id)
        @away_win_matches = MatchResult.where(win_team_id: @away_team.id)
        @away_loss_matches = MatchResult.where(loss_team_id: @away_team.id)
        @away_team.points = 1000 + 25 * @away_win_matches.count - 25 * @away_loss_matches.count

        @home_team.save
        @away_team.save
      end
      redirect_to match_path(@match), flash: { info: 'Match was successfully updated.' }
    else
      flash[:error] = @match.errors.full_messages.to_sentence
      render 'select'
    end
  end

  private
    def set_admin
      @admin = Player.find_by(email: "admin@soccerchallenge.com")
    end

    def set_match
      @match = Match.find(params[:id])
      @home_team = Team.find(@match.team_owner_id)
      @home_team_owner = Player.find(@home_team.team_owner.player_id)
      @home_team_players = @home_team.players.first(5)
      if @match.team_away_id
        @away_team = Team.find(@match.team_away_id)
        @away_team_players = @away_team.players.first(5)
      end
    end

    def match_params
      if current_player.email == "admin@soccerchallenge.com"
        params.require(:match).permit(:team_owner_id, :team_away_id, :venue_id, :field_id, :starts_at, :ends_at, :is_start, :is_end, :home_goal, :away_goal)
      else
        params.require(:match).permit(:team_owner_id, :team_away_id, :venue_id, :field_id, :starts_at, :ends_at, :is_start, :home_goal, :away_goal)
      end
    end
end
