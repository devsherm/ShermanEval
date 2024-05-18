# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(email: 'admin@example.com', password: 'admin!', password_confirmation: 'admin!', admin: true)
User.create(email: 'applicant1@example.com', name: "Applicant 1", password: 'applicant1', password_confirmation: 'applicant1', admin: false)
User.create(email: 'applicant2@example.com', name: "Applicant 2", password: 'applicant2', password_confirmation: 'applicant2', admin: false)