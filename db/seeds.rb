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