class CreateMatchRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :match_requests do |t|
      t.integer :match_id
      t.integer :team_id

      t.timestamps
    end
  end
end
