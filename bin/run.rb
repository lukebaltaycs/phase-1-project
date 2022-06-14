require_relative '../config/environment'

Album.delete_all
Artist.delete_all
User.delete_all
PersonalCollection.delete_all

kdot = Artist.create(:name=> "Kendrick Lamar", :artist_spotify_id=> "Kdot-spotify-id")
tpab = Album.create(:name=> "To Pimp a Butterfly", :album_spotify_id => "Tpab-spotify-id")
tpab.artist= kdot
kdot.albums << tpab
puts kdot.albums.first.name




luke = User.create(name: "Luke")
lukepc = luke.make_new_personal_collection("hip-hop classics")
#luke.add_album_to_personal_collection(album: tpab, personal_collection: lukepc)

binding.pry