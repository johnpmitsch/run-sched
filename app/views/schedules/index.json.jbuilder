json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :race_day, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :race_type, :user_id
  json.url schedule_url(schedule, format: :json)
end
