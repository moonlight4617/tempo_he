# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@prefecture = ["東京都", "神奈川県", "埼玉県", "千葉"]
shop_name = Faker::Creature::Animal.name
zip_code = Faker::Address.zip_code
city = Faker::Address.city
tel = Faker::PhoneNumber.phone_number
station = Faker::Mountain.name
# 10.times do |n|
#   name = Faker::Name.name
#   email = Faker::Internet.email
#   password = '12345678'
#   owner = Owner.create!(
#     name: name,
#     email: email,
#     password: password,
#     password_confirmation: password,
#   )
#   Shop.create!(
#     owner_id: owner.id,
#     name: shop_name,
#     zip_code: zip_code,
#     prefecture: @prefecture[Faker::Number.within(range: 0..4)],
#     city: city,
#     tel: tel,
#     station: station,
#   )
# end

# Tag.create(
#   name: "コンセントあり"
# )
# Tag.create(
#   name: "wifiあり"
# )
# Tag.create(
#   name: "１棟丸ごと貸しOK"
# )
# Tag.create(
#   name: "終日貸しOK"
# )
# Tag.create(
#   name: "駅から徒歩１０分以内"
# )
# Tag.create(
#   name: "定期貸しOK"
# )
# Tag.create(
#   name: "喫煙OK"
# )
# Tag.create(
#   name: "テラス席あり"
# )

User.create!(
  name: "sample_user",
  email: "sample_user@gmail.com",
  password: "12345678",
)

owner = Owner.create!(
  name: "sample_owner",
  email: "sample_owner@gmail.com",
  password: "12345678",
)

Shop.create!(
  owner_id: owner.id,
  name: shop_name,
  zip_code: zip_code,
  prefecture: @prefecture[Faker::Number.within(range: 0..4)],
  city: city,
  tel: tel,
  station: station,
)