class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:sign_in_field_owner]

      if @field_owner = FieldOwner.find_by(:email => params[:email]) and @field_owner.authenticate(params[:password])
        flash[:success] = "Field owner sign in successfully"
        session[:field_owner_id] = @field_owner.id
  
      else
        flash[:error] = "Invalid username or password"
        render 'new'
      end

    elsif params[:sign_in_player]
      if @player = Player.find_by(:email => params[:email]) and @player.authenticate(params[:password])
        flash[:success] = "Player sign in successfully"
        session[:player_id] = @player.id

      else
        flash[:error] = "Invalid username or password"
        render 'new'
      end      
    end
  end

  def destroy
    if current_player
      session[:player_id] = nil
    elsif current_field_owner
      session[:field_owner_id] = nil  
    end
    
    flash[:success] = "Sign out successfully"
    redirect_to root_path
  end
end
