class HomeController < ApplicationController
  def index
    if current_player
      redirect_to teams_path
    end
  end
end
