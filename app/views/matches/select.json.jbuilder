json.array!(@matches) do |match|
  json.extract! match, :id, :team_owner_id, :team_away_id, :venue_id, :field_id, :is_start, :is_end
  json.start match.starts_at
  json.end match.ends_at
  json.update_url match_path(match, method: :patch)
  json.edit_url edit_match_path(match)
end