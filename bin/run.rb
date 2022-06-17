require_relative '../config/environment'

#Album.delete_all
#Artist.delete_all
#User.delete_all
#PersonalCollection.delete_all
#AlbumCollect.delete_all
#Link.delete_all
#LastFmClone.delete_all

#kdot = Artist.create(:name=> "Kendrick Lama")
#kdot.enter_album("To Pimp A Butter")
#kdot.enter_album("DAmn")
#kdot.enter_album("good kid, mad city")
#strokes = Artist.create(name: "The Strokes")
#strokes.enter_album("Is This It")
#iti = strokes.albums.first
#strokes.enter_album("woopadoop")
#woo = strokes.albums.last
#strokes.enter_album("Room On Fire")

#luke = User.create(name: "Luke")
#lukepc = luke.make_new_personal_collection("classics")
#luke.add_album_to_personal_collection(Album.find_by(name: "To Pimp A Butterfly"), lukepc)
#luke.add_album_to_personal_collection(Album.find_by(name: "Room On Fire"), lukepc)
#lpc = luke.personal_collections.first
#lpc.add_album(iti)
#lpc.add_album(woo)


#luke.add_link_easy("Is This It", "https://www.youtube.com/watch?v=RHrGj1IyE0Y&ab_channel=TheStrokes-Topic")
#luke.add_link_easy("Is This It", "www.youtube.com/strokesiti")
#Album.find_by_name("Is This It").link_is_invalid("youtube")


#binding.pry



#url = "theaudiodb.com/api/v1/json/{APIKEY}/discography.php?s=coldplay"
#uri = URI.parse(url)
#response = Net::HTTP.get_response(uri)
#JSON.parse(response.body)
Cli.clear_charts
#puts Album.all.first.links.first.info

Cli.login_page

binding.pry

# Have One On Me by Joanna Newsom
# https://www.amazon.com/Have-One-Me-Joanna-Newsom/dp/B0034C263A
# Ys by Joanna Newsom
# Endless by Frank Ocean
# https://www.youtube.com/watch?v=AHLFNoT64HQ&ab_channel=DOC-A-THONT.V.
# Earl by Earl Sweatshirt
# https://www.soundcloud.com/earl-album-fskabkdjvbkah

#if !init.collect{|album| album.name}.include?(searchname) || !init.collect{|album| album.artists.first.name}.include?(artist_name)
# 

RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
#RSpotify::Album.search("Donda").map{|album| album.artists.first.name}.include?("Kanye West")