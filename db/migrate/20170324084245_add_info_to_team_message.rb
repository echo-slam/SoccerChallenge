class AddInfoToTeamMessage < ActiveRecord::Migration[5.0]
  def change
    add_reference :team_messages, :team, foreign_key: true
    add_column :team_messages, :player_id, :string
  end
end
