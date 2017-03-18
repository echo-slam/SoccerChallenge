class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.integer :field_owner_id
      t.string :name
      t.string :addr
      t.string :image_url
      t.string :venue

      t.timestamps
    end
  end
end
