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
  end

  def show
  end

  def edit
  end

  private
    def player_result_params
      params.require(:player_result).permit(:goal)
    end
end
