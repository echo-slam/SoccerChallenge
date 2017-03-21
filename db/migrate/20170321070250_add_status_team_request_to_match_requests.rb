class AddStatusTeamRequestToMatchRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :match_requests, :team_request_id, :integer
    add_column :match_requests, :status, :string, :default => 'PENDING'
  end
end
