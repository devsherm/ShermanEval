# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_admin = User.find_or_initialize_by(email: "admin@example.com", admin: true)

if user_admin.new_record?
  user_admin.password = 'password'
  user_admin.save
end

['user@example.com', 'user2@example.com'].each do |email|
  user = User.find_or_initialize_by(email:)

  if user.new_record?
    user.password = 'password'
    user.save
  end
end