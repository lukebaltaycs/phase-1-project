require_relative '../config/environment'

Album.delete_all
Artist.delete_all
User.delete_all
PersonalCollection.delete_all
AlbumCollect.delete_all
Link.delete_all

kdot = Artist.create(:name=> "Kendrick Lamar", :artist_spotify_id=> "Kdot-spotify-id")
kdot.enter_album("To Pimp A Butterfly", "Tpab-spotify-id")
kdot.enter_album("Damn", "Damn-spotify-id")
kdot.enter_album("Good Kid M.A.A.D. City", "Gkmc-spotify-id")
strokes = Artist.create(name: "The Strokes", artist_spotify_id: "Strokes-spotify-id")
strokes.enter_album("Is This It", "Iti-spotify-id")
strokes.enter_album("Room On Fire", "Rof-spotify-id")

luke = User.create(name: "Luke")
lukepc = luke.make_new_personal_collection("classics")
luke.add_album_to_personal_collection(Album.find_by(name: "To Pimp A Butterfly"), lukepc)
luke.add_album_to_personal_collection(Album.find_by(name: "Room On Fire"), lukepc)

luke.add_link(Album.all.find_by(name: "Damn"), "www.damn.com")
luke.add_link_easy("Is This It", "https://www.youtube.com/watch?v=RHrGj1IyE0Y&ab_channel=TheStrokes-Topic")

puts Album.find_by_name("Is This It").return_album_links
Album.find_by_name("Is This It").return_album_info

binding.pry