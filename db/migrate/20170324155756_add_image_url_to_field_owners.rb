class AddImageUrlToFieldOwners < ActiveRecord::Migration[5.0]
  def change
    add_column :field_owners, :image_url, :string
  end
end
