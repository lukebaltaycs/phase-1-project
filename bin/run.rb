require_relative '../config/environment'

Album.delete_all
Artist.delete_all
User.delete_all
PersonalCollection.delete_all
AlbumCollect.delete_all
Link.delete_all

kdot = Artist.create(:name=> "Kendrick Lamar")
kdot.enter_album("To Pimp A Butterfly")
kdot.enter_album("DAMN.")
kdot.enter_album("good kid, m.A.A.d city")
strokes = Artist.create(name: "The Strokes")
strokes.enter_album("Is This It")
strokes.enter_album("Room On Fire")

luke = User.create(name: "Luke")
lukepc = luke.make_new_personal_collection("classics")
luke.add_album_to_personal_collection(Album.find_by(name: "To Pimp A Butterfly"), lukepc)
luke.add_album_to_personal_collection(Album.find_by(name: "Room On Fire"), lukepc)

luke.add_link_easy("Is This It", "https://www.youtube.com/watch?v=RHrGj1IyE0Y&ab_channel=TheStrokes-Topic")
#luke.add_link_easy("Is This It", "www.youtube.com/strokesiti")
#Album.find_by_name("Is This It").link_is_invalid("youtube")

# puts RSpotify::Album.find(Album.find_by_name("Is This It").album_spotify_id).tracks_cache.map{|track| track.name}

binding.pry