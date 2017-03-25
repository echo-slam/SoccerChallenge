class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_field_owner, :current_player, :player_belongs_to_team

  def current_field_owner
    @current_field_owner ||= FieldOwner.find_by_id(session[:field_owner_id])
  end

  def current_player
    @current_player ||= Player.find_by_id(session[:player_id])
  end

  def check_current_field_owner
    unless current_field_owner
      flash[:error] = "You must be field owner to conduct this action"
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
end
