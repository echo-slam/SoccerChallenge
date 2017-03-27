class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :notified_by_id
      t.integer :player_id
      t.string :notice_type
      t.string :notice_messages
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
