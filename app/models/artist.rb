class Artist < ActiveRecord::Base
    has_many :albums

    before_create :search_on_spotify

    def enter_album(name)
        new_album = Album.create(name: name)
        new_album.artist = self
        self.albums << new_album
    end

    def search_on_spotify 
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
        self.artist_spotify_id = RSpotify::Artist.search(self.name).first.id
    end


end