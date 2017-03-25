class AddImageUrlToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :image_url, :string
  end
end
