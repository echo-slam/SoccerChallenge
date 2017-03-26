desc 'Fetch player'

task :fetch_player => :environment do
  require 'nokogiri'
  require 'open-uri'

  url = "#{Rails.root}/lib/references/player_100.html"
  doc = Nokogiri::HTML(open(url))

  player = []
  image = []
  club = []


  doc.css(".b-loaded").each do |image_url|
    file = image_url["data-imgstem"] + '/500.jpg'
    image.push file 
  end

  doc.css("#gv-grid h3").each do |player_name|
    player.push player_name.text
  end

  doc.css("#gv-grid p").each do |club_name|
    club.push club_name.text
  end

  (0..99).each do |e|
    PlayerReference.create name: player[e], club: club[e], image_url: image[e]
  end
end