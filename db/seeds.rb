# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Venue
['District 1', 'District 2', 'District 3', 'District 4', 'District 5', 'District 6',
 'District 7', 'District 8', 'District 9', 'District 10', 'District 11', 'District 12',
 'Binh Chanh', 'Binh Tan', 'Binh Thanh', 'Can Gio', 'Cu Chi', 'Go Vap',
 'Hoc Mon', 'Nha Be', 'Phu Nhuan', 'Tan Binh', 'Tan Phu', 'Thu Duc'].each do |d|
     Venue.create(name: d)
   end

Rake::Task['fetch_player'].invoke

# Create player from references

(0..4).each do |player|
  random_index = rand(1..100)
  player = PlayerReference.find(random_index)
  Player.create(full_name: player.name, email: player.name.delete(' ') + "@gmail.com", password: "123")
end