class TeamMessagesController < ApplicationController
  def create
    set_team
    @team_message = @team.team_messages.build team_message_params
    @team_message.player_id = current_player.id
    @team_message.save

    respond_to do |format|
      format.html do
        if @team_message.persisted?
          redirect_to @team
        else
          flash[:error] = "Error #{@team_message.errors.full_messages.to_sentence}"
          redirect_back fallback_location: team_path(@team)
        end
      end

      format.js
    end
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def team_message_params
      params.require(:team_message).permit(:body)
    end
end
