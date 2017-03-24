class AddKindToTeamRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :team_requests, :kind, :string
  end
end
