class HomeController < ApplicationController
  def index
    if current_player
      redirect_to signed_in_index_path
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def signed_in_index
    @player = current_player

    if @player.team_id
      @team = Team.find(@player.team_id)
      @num_of_members = @team.players.count
    end
  end
end
