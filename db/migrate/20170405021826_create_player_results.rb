class CreatePlayerResults < ActiveRecord::Migration[5.0]
  def change
    create_table :player_results do |t|
      t.integer :match_id
      t.integer :player_id
      t.integer :goal

      t.timestamps
    end
  end
end
