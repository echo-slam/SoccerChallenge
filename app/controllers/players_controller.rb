class PlayersController < ApplicationController
  def index
    @players = Player.all.order("full_name DESC")

    if params[:search]
      @players = Player.search(params[:search]).order("full_name DESC")
    end
  end

  def show
    set_player
    @team = Team.find(@player.team_id) if @player.team_id
  end

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
    def set_player
      @player = current_player
    end
    def player_params
      params.require(:player).permit(:full_name, :email, :password)
    end
end
