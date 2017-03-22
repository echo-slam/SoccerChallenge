class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_field_owner, :current_player, :player_belongs_to_team

  def current_field_owner
    @current_field_owner ||= FieldOwner.find_by_id(session[:field_owner_id])
  end

  def current_player
    @current_player ||= Player.find_by_id(session[:player_id])
  end
  def check_team_owner_permission
    @team = Team.find_by_id(params[:id])
    unless current_player.team_owner.team_id == @team.id
      flash[:error] = "You must be team owner to conduct this action"
      redirect_to root_path
    end
  end
end
