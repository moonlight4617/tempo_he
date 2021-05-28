# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@prefecture = ["東京都", "神奈川県", "埼玉県", "千葉"]
3.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = '12345678'
  owner = Owner.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
  )
  shop_name = Faker::Creature::Animal.name
  zip_code = Faker::Address.zip_code
  city = Faker::Address.city
  tel = Faker::PhoneNumber.phone_number
  station = Faker::Mountain.name
  Shop.create!(
    owner_id: owner.id,
    name: shop_name,
    zip_code: zip_code,
    prefecture: @prefecture[n],
    city: city,
    tel: tel,
    station: station,
  )
end