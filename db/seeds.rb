# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: "bob")
User.create(first_name: "rob")
User.create(first_name: "anne")
User.create(first_name: "sally")
User.create(first_name: "jesus")

Star.create(star: 1)
Star.create(star: 2)
Star.create(star: 3)

Specialty.create(specialty: "History")
Specialty.create(specialty: "Nightlife")
Specialty.create(specialty: "Food")

Language.create(language: "English")
Language.create(language: "Spainish")
Language.create(language: "Korean")
Language.create(language: "German")

