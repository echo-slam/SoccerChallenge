class AddIsEndToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :is_end, :boolean
  end
end
