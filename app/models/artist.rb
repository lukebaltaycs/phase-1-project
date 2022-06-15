class Artist < ActiveRecord::Base
    has_many :albums

    def enter_album(name, album_spotify_id)
        new_album = Album.create(name: name, album_spotify_id: album_spotify_id)
        new_album.artist = self
        self.albums << new_album
    end
    
end