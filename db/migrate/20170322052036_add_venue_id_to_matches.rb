class AddVenueIdToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :venue_id, :integer
  end
end
