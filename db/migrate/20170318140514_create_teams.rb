class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :team_owner_id
      t.string :name
      t.integer :points, :default => 1000

      t.timestamps
    end
  end
end
