class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.integer :team_id
      t.string :full_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
