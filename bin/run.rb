require_relative '../config/environment'


#kdot = Artist.create(:artist_name=> "Kendrick Lamar", :artist_spotify_id=> "Kdot-spotify-id")
#kdot = Artist.new
#kdot.name = "Kendrick Lamar"
#kdot.artist_spotify_id = "Kdot-spotify-id"
#tpab = Album.create(:album_name=> "To Pimp a Butterfly", :album_spotify_id => "Tpab-spotify-id")
#tpab.artist= kdot
#kdot.albums << tpab

#binding.pry

kdot = Artist.create(name: "Kendrick Lamar")
tpab = Album.create(name: "To Pimp A Butterfly")
tpab.artist = kdot
kdot.albums << tpab
puts kdot.albums.first.name




#luke = User.create(name: "Luke")
#luke.make_new_personal_collection(name: "hip-hop classics")
#luke.add_album_to_personal_collection(tpab, luke.personal_collections.find(name: "hip-hop classics"))
