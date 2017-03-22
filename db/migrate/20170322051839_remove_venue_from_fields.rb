class RemoveVenueFromFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :fields, :venue, :string
  end
end
