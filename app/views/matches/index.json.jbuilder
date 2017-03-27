json.array!(@matches) do |match|
  json.extract! match, :id, :team_owner_id, :team_away_id, :venue_id, :field_id, :is_start
  json.start match.starts_at
  json.end match.ends_at
  json.url match_url(match, format: :json)
end