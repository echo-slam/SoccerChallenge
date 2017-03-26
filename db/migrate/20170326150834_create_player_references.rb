class CreatePlayerReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :player_references do |t|
      t.string :name
      t.string :club
      t.string :image_url

      t.timestamps
    end
  end
end
