class Artist < ActiveRecord::Base
    has_many :albums

    before_create :search_on_spotify

    def enter_album(name)
        new_album = Album.create(name: name)
        new_album.artist = self
        new_album.assign_onspotify
        self.albums << new_album
        new_album.save
        self.save      
    end

    def cleanup
        self.check_name_on_lastfm
        self.albums.each {|album| album.check_name_on_lastfm}
    end

    def check_name_on_lastfm
        lastfm = Lastfm.new("227863264027c5a3c3408d22a1fe992d", "2d1e640d3a44317c1ca713516f822727")
        self.update_attribute(:name, lastfm.artist.search(artist: self.name)["results"]["artistmatches"].first[1][0]["name"])
        self.save
    end


    def search_on_spotify 
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
        self.artist_spotify_id = RSpotify::Artist.search(self.name).first.id
    end


end