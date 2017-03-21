class MatchesController < ApplicationController
  def index
    @matches = Match.upcoming
  end
end
