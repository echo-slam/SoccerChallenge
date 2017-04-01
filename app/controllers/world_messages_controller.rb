class WorldMessagesController < ApplicationController
  def index
    @world_messages = WorldMessage.order(created_at: "DESC").first(100)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @world_message = WorldMessage.new world_message_params
    @world_message.player_id = current_player.id
    @world_message.save

    respond_to do |format|
      format.html do
        if @world_message.persisted?
          redirect_to :back
        else
          flash[:error] = "Error #{@team_message.errors.full_messages.to_sentence}"
          redirect_to :back
        end
      end

      format.js
    end
  end

  private
    def world_message_params
      params.require(:world_message).permit(:body)
    end
end
