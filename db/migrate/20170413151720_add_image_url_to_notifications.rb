class AddImageUrlToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :image_url, :string
  end
end
