# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# create one admin user and one client user

user1 =
  User.create(
    [
      {
        first_name: "Admin",
        last_name: "User",
        email: "admin@example.com",
        password: "password",
        user_type: "alumni"
      },
      {
        first_name: "Client",
        last_name: "User",
        email: "client@example.com",
        password: "password",
        user_type: "client"
      }
    ]
  )
