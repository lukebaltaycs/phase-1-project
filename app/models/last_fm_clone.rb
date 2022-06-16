class LastFmClone < ActiveRecord::Base
    belongs_to :album

    after_initialize :setup

    def setup
        self.get_name
        #self.get_artist
        #self.get_last_fm_url
        #self.get_summary
        self.save
    end

    def get_self
        lastfm = Lastfm.new("227863264027c5a3c3408d22a1fe992d", "2d1e640d3a44317c1ca713516f822727")
        lastfm.album.get_info(artist: self.album.artist.name, album: self.album.name)
    end

    def get_name
        album = self.get_self
        self.write_attribute(:name, album["name"])
    end
end