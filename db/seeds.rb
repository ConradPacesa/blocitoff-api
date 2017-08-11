require 'faker'


#create users
10.times do
  User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end

users = User.all

#create items
30.times do
  Item.create!(
  name: Faker::Food.ingredient,
  user: users.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Item.count} items created"
