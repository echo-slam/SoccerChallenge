class PlayerResultsController < ApplicationController
  def new
    @player_result = PlayerResult.new
    @match_id = params[:match_id]
  end

  def create
    @player_result = PlayerResult.new player_result_params
    @player_result.match_id = params[:match_id]
    @player_result.player_id = current_player.id

    @player_result.save

    @player = current_player
    @player_results = PlayerResult.where(player_id: @player.id)
    @player.games_played = @player_results.count

    @goals = 0
    if @player_results.count > 0
      @player_results.each do |result|
        @goals += result.goal
      end
    end

    @player.goal = @goals
    @player.save

    redirect_to match_path(@player_result.match_id)
  end

  private
    def player_result_params
      params.require(:player_result).permit(:goal)
    end
end
