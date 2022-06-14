
kdot = Artist.new("Kendrick Lamar", "Kdot-spotify-id")
tpab = Album.new("To Pimp a Butterfly", "Tpab-spotify-id")
tpab.artist = kdot

luke = User.new("Luke")
luke.make_new_personal_collection("hip-hop classics")
luke.add_album_to_personal_collection(tpab, luke.personal_collections.find(name: "hip-hop classics"))
