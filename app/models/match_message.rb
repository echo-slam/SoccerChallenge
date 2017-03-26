class MatchMessage < ApplicationRecord
  belongs_to :match
  validates :body, presence: true

  def player_name
    Player.find(player_id) || 'Player'
  end
end
