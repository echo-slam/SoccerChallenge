require 'custom_render_sum.rb'

class PlayersController < ApplicationController
  def index
    @players = Player.all.order("full_name ASC")
    @team_requests = TeamRequest.where(team_id: current_player.team_id).where(kind: "request")
    @team_invites = TeamRequest.where(team_id: current_player.team_id).where(kind: "invite") 

    if params[:search]
      @players = Player.search(params[:search]).order("full_name DESC")
    end
  end

  def show
    set_player

    @articles = @player.articles.order(created_at: "DESC")

    @markdown = Redcarpet::Markdown.new(CustomRenderSum)

    @world_messages = WorldMessage.order(created_at: "DESC").first(100)
    @channel = "world"

    if params[:channel] == "world"
      @channel = "world"
    elsif params[:channel] == "team"
      @channel = "team"
    end

    @team = Team.find(@player.team_id) if @player.team_id
    @team_messages = @team.team_messages.order(created_at: "DESC").first(50) if @player.team_id
    @team_invitations = TeamRequest.where(player_id: current_player.id).where(kind: "invite")

    @team_requests = TeamRequest.where(team_id: current_player.team_id).where(kind: "request")
    @team_invites = TeamRequest.where(team_id: current_player.team_id).where(kind: "invite") 
  end

  def new
    @player = Player.new
  end

  def edit
    set_player
  end

  def update
    set_player

    if @player.update(player_params)
      flash[:success] = 'Update Profile successfully'
      redirect_to player_path(@player)
    else
      flash[:error] = @player.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def create
    @player = Player.new player_params
    if @player.save

      PlayerMailer.welcome_player(@player).deliver_later
      
      flash[:success] = 'Register successfully'
      session[:player_id] = @player.id

      #Create team_owner record
      @player.create_team_owner
      
      redirect_to signed_in_index_path
    else
      flash[:error] = @player.errors.full_messages.to_sentence
      render 'new'
    end

  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:full_name, :email, :password, 
                                     :image_url, :nickname, :favorite_team, :favorite_player)
    end
end