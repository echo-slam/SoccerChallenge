class AddVerifyToPlayerResult < ActiveRecord::Migration[5.0]
  def change
    add_column :player_results, :verify_status, :boolean
  end
end
