class RemoveTypeFromTeamRequest < ActiveRecord::Migration[5.0]
  def change
    remove_column :team_requests, :type, :string
  end
end
