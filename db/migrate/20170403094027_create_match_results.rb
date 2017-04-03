class CreateMatchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :match_results do |t|
      t.integer :match_id
      t.integer :win_team_id
      t.integer :loss_team_id

      t.timestamps
    end
  end
end
