class AddStatusTeamRequestToMatchRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :match_requests, :requested_team_id, :integer
    add_column :match_requests, :status, :string, :default => 'PENDING'
  end
end
