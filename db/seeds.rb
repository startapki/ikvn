users = User.create!([{
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.zone.now,
  role: User.roles[:admin]
}, {
  email: 'judge@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.zone.now,
  role: User.roles[:judge]
}, {
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.zone.now
}])

League.create!([{
  name: 'Винни(ца) Пух',
  description: Faker::Lorem.paragraph
}])

Tournament.create!([{
  name: 'Интернет Чемпионат КВН',
  description: Faker::Lorem.paragraph,
  league: League.first
}])

seasons = Season.create!([{
  name: 'Первый сезон',
  description: Faker::Lorem.paragraph,
  tournament: Tournament.first
}, {
  name: 'Второй сезон',
  description: Faker::Lorem.paragraph,
  tournament: Tournament.first
}])

tours = Tour.create!([{
  name: 'Первый тур',
  description: Faker::Lorem.paragraph,
  season: Season.first,
  started_at: Time.zone.now - 11.days,
  finished_at: Time.zone.now - 5.days,
  reviewed_at: Time.zone.now
}, {
  name: 'Второй тур',
  description: Faker::Lorem.paragraph,
  season: Season.first,
  started_at: Time.zone.now - 3.days,
  finished_at: Time.zone.now,
  reviewed_at: Time.zone.now + 4.days
}, {
  name: 'Третий тур',
  description: Faker::Lorem.paragraph,
  season: Season.first,
  started_at: Time.zone.now,
  finished_at: Time.zone.now + 6.days,
  reviewed_at: Time.zone.now + 14.days
}, {
  name: 'Четвертый тур',
  description: Faker::Lorem.paragraph,
  season: Season.first,
  started_at: Time.zone.now + 7.days,
  finished_at: Time.zone.now + 15.days,
  reviewed_at: Time.zone.now + 21.days
}, {
  name: 'Первый тур',
  description: Faker::Lorem.paragraph,
  season: Season.last,
  started_at: nil,
  finished_at: nil,
  reviewed_at: nil
}])

problems = Problem.create!([{
  content: 'Hello?',
  tour: tours[2]
}, {
  content: 'World?',
  tour: tours[2]
}, {
  content: 'Outdated?',
  tour: tours[1]
}])

participations = Participation.create!([{
  season: seasons.first,
  user: users.last
}])

Solution.create!([{
  participation: participations.first,
  problem: problems.last,
  content: 'Solution!'
}])
