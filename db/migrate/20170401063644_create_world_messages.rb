class CreateWorldMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :world_messages do |t|
      t.integer :player_id
      t.string :body

      t.timestamps
    end
  end
end
