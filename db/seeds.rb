User.create!([{
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.now
}])

League.create!([{
  name: 'Винни(ца) Пух',
  description: Faker::Lorem.paragraph
}, {
  name: 'Second League',
  description: Faker::Lorem.paragraph
}])

Tournament.create!([{
  name: 'Интернет Чемпионат',
  description: Faker::Lorem.paragraph,
  league: League.first
}, {
  name: 'Second Tournament',
  description: Faker::Lorem.paragraph,
  league: League.first
}])

Season.create!([{
  name: 'Первый сезон',
  description: Faker::Lorem.paragraph,
  tournament: Tournament.first
}, {
  name: 'Second Season',
  description: Faker::Lorem.paragraph,
  tournament: Tournament.first
}])

Tour.create!([{
  name: 'Первый тур',
  description: Faker::Lorem.paragraph,
  season: Season.first
}, {
  name: 'Second Tour',
  description: Faker::Lorem.paragraph,
  season: Season.first
}])
