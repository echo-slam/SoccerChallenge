json.array!(@matches) do |match|
  json.extract! match, :id, :team_owner_id, :team_away_id, :venue_id, :field_id, :is_start, :is_end, :home_goal, :away_goal
  json.title match.field_name_or_default + ' - ' + match.venue_name
  json.start match.starts_at
  json.end match.ends_at
end