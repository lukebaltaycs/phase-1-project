class Artist < ActiveRecord::Base
    has_many :albums

    def enter_album(name, album_spotify_id)
        new_alb = Album.create(name: name, album_spotify_id: album_spotify_id)
        new_alb.artist = self
        self.albums << new_alb
    end  
    
end