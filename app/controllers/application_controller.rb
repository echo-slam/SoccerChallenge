class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_field_owner
  helper_method :current_player

  def current_field_owner
    @current_field_owner ||= FieldOwner.find_by_id(session[:field_owner_id])
  end

  def current_player
    @current_player ||= Player.find_by_id(session[:player_id])
  end

end
