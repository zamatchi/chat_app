# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do |n|
  name = "Exsample#{n+59}"
  genre = rand(1..12)
  target = rand(1..3)
  comment = "お試しルーム#{n+59}。"
  user_id = 7
  Chatroom.create!(name: name, genre: genre, target: target, comment: comment, user_id: user_id)
end
