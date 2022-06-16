class LastFmClone < ActiveRecord::Base
    belongs_to :album

    def setup
        album = self.get_self
        self.write_attribute(:name, album["name"])
        self.write_attribute(:name, album["artist"])
        #self.get_name
        #self.get_artist
        self.get_last_fm_url
        self.get_summary
    end

    def get_self
        self.album.search_on_lastfm
    end

    def get_name
        album = self.get_self
        self.write_attribute(:name, album["name"])
    end

    def get_artist
        self.write_attribute(:name, self.get_self["artist"])
    end

    def get_last_fm_url
        self.update_attribute(:name, self.get_self["url"])
    end

    def get_summary
        self.update_attribute(:name, self.get_self["wiki"["content"]])
    end

end