class MatchMessagesController < ApplicationController
  before_action :set_match, only: [:create]

  def create
    @match_message = @match.match_messages.build message_params
    @match_message.player_id = current_player.id
    @match_message.save

    respond_to do |format|
      format.html do
        if @match_message.persisted?
          redirect_to waiting_match_path(@match)
        else
          flash[:error] = @match_message.errors.full_messages.to_sentence
          redirect_back fallback_location: waiting_match_path(@match)
        end
      end

      format.js
    end
  end

  private
    def set_match
      @match = Match.find(params[:match_id])
    end

    def message_params
      params.require(:match_message).permit(:body)
    end
end
