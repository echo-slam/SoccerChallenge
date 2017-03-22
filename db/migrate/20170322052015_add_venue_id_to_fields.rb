class AddVenueIdToFields < ActiveRecord::Migration[5.0]
  def change
    add_column :fields, :venue_id, :integer
  end
end
