# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: "yiliangt5", 
             email: "ydatylmonv@gmail.com", 
             password: "q8zkp4gtyx", 
             password_confirmation: "q8zkp4gtyx",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  username = Faker::Name.first_name
  email = "#{username.downcase}@gmail.com"
  password = "password"
  if !User.find_by(username: username)
    User.create!(username: username,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
  end
end
