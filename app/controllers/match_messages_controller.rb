class MatchMessagesController < ApplicationController
  before_action :set_match, only: [:index, :create]

  def index
    @match_messages = @match.match_messages.order(created_at: "DESC").first(50)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @match_message = @match.match_messages.build match_message_params
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

    def match_message_params
      params.require(:match_message).permit(:body)
    end
end
