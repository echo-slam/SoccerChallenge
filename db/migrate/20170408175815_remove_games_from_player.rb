class RemoveGamesFromPlayer < ActiveRecord::Migration[5.0]
  def change
    remove_column :players, :games_played, :integer
  end
end
