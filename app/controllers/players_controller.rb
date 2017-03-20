class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new player_params
    if @player.save
      flash[:success] = 'Register successfully'
      session[:player_id] = @player.id

      #Create team_owner record
      @player.create_team_owner
      
      redirect_to root_path
    else
      flash[:error] = @player.errors.full_messages.to_sentence
      render 'new'
    end

  end

  private
    def player_params
      params.require(:player).permit(:full_name, :email, :password)
    end

end
