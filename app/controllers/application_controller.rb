class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_field_owner, :current_player, :check_match_permission, :check_admin_permission

  def current_field_owner
    return @current_field_owner if @current_field_owner
    @current_field_owner ||= FieldOwner.find_by_id(session[:field_owner_id])
  end

  def current_player
    return @current_player if @current_player
    @current_player ||= Player.find_by_id(session[:player_id])
  end

  def check_current_field_owner
    unless current_field_owner
      flash[:error] = "You must be Field Owner to conduct this action"
      redirect_to root_path
    end
  end

  def check_field_permission
    @field = Field.find(params[:id])
    unless current_field_owner.id == @field.field_owner_id  
      flash[:error] = "You don't have permission to conduct this action"
      redirect_to root_path
    end
  end

  def check_match_permission
    unless current_player.team_owner.team_id
      flash[:error] = "You must be Team Owner to conduct this action"
      redirect_to root_path
    end
  end

  def check_admin_permission
    unless current_player.email == 'admin@soccerchallenge.com'
      flash[:error] = "You must be Administrator to conduct this action"
      redirect_to root_path
    end
  end
end
