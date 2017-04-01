class AddInfoToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :nickname, :string
    add_column :players, :favorite_player, :string
    add_column :players, :favorite_team, :string
  end
end
