class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :team_owner_id
      t.integer :team_away_id
      t.integer :field_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :is_start
      t.integer :home_goal
      t.integer :away_goal

      t.timestamps
    end
  end
end
