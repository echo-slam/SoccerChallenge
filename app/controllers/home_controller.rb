class HomeController < ApplicationController
  def index
    if current_player
      redirect_to teams_path
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
