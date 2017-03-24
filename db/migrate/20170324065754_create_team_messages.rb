class CreateTeamMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :team_messages do |t|
      t.string :body

      t.timestamps
    end
  end
end
