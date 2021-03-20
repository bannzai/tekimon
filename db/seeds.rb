# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach('db/seed.csv', headers: true) do |row|
  IrasutoyaMonster.create(
    name: row['name'],
    page_url: row['page_url'],
    image_url: row['image_url'],
    attack_point: row['attack_point']
  )
end
