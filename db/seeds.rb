# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Category.create(label: "Red")
Category.create(label: "Yellow")
Category.create(label: "Green")
Category.create(label: "Has extra")
Category.create(label: "Passed")

Question.create(answer_type: "type_text", text: "Please type some text here", options: nil)
Question.create(answer_type: "select_one", text: "Please select one from", options: "Option One\nOption Two\nOption Three")
Question.create(answer_type: "select_multiple", text: "Please select multiple from", options: "Line 1\nLine 2\nLine 3")
