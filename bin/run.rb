require_relative '../config/environment'

Album.delete_all
Artist.delete_all
User.delete_all
PersonalCollection.delete_all
AlbumCollect.delete_all
Link.delete_all
LastFmClone.delete_all

kdot = Artist.create(:name=> "Kendrick Lama")
kdot.enter_album("To Pimp A Butter")
kdot.enter_album("DAmn")
kdot.enter_album("good kid, mad city")
strokes = Artist.create(name: "The Strokes")
strokes.enter_album("Is This It")
iti = strokes.albums.first
#strokes.enter_album("woopadoop")
#woo = strokes.albums.last
#strokes.enter_album("Room On Fire")

luke = User.create(name: "Luke")
#lukepc = luke.make_new_personal_collection("classics")
#luke.add_album_to_personal_collection(Album.find_by(name: "To Pimp A Butterfly"), lukepc)
#luke.add_album_to_personal_collection(Album.find_by(name: "Room On Fire"), lukepc)
lpc = luke.personal_collections.first
lpc.add_album(iti)
#lpc.add_album(woo)


#luke.add_link_easy("Is This It", "https://www.youtube.com/watch?v=RHrGj1IyE0Y&ab_channel=TheStrokes-Topic")
#luke.add_link_easy("Is This It", "www.youtube.com/strokesiti")
#Album.find_by_name("Is This It").link_is_invalid("youtube")


binding.pry



#url = "theaudiodb.com/api/v1/json/{APIKEY}/discography.php?s=coldplay"
#uri = URI.parse(url)
#response = Net::HTTP.get_response(uri)
#JSON.parse(response.body)
