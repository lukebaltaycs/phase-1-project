require_relative '../config/environment'

Album.delete_all
Artist.delete_all
User.delete_all
PersonalCollection.delete_all
AlbumCollect.delete_all

kdot = Artist.create(:name=> "Kendrick Lamar", :artist_spotify_id=> "Kdot-spotify-id")
kdot.enter_album("To Pimp A Butterfly", "Tpab-spotify-id")

luke = User.create(name: "Luke")
lukepc = luke.make_new_personal_collection("hip-hop classics")
#puts kdot.albums.first.name
luke.add_album_to_personal_collection(Album.find_by(name: "To Pimp A Butterfly"), lukepc)

binding.pry