json.array!(@matches) do |match|
  json.extract! match, :id, :team_owner_id, :team_away_id, :venue_id, :field_id, :is_start, :is_end
  json.title match.home_team_name + ' - ' + match.venue_name
  json.host_id match.captain_id
  json.viewer_id current_player.id
  json.start match.starts_at
  json.end match.ends_at
  json.update_url match_path(match, method: :patch)
  json.edit_url edit_match_path(match)
end