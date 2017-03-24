class CreateTeamRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :team_requests do |t|
      t.integer :player_id
      t.integer :team_id
      t.string :type

      t.timestamps
    end
  end
end
