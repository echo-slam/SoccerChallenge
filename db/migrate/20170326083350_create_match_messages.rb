class CreateMatchMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :match_messages do |t|
      t.string :body
      t.integer :player_id
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
