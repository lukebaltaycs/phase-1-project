class PersonalCollection < ActiveRecord::Base
    belongs_to :user
    has_many :album_collects
    has_many :albums, through: :album_collects

    def albums
        self.album_collects.map{|collect| collect.album}
    end

    def add_album(album)
        AlbumCollect.create(album: album, personal_collection: self, time_created: DateTime.current())
    end

    def add_album_by_title(name)
        AlbumCollect.create(album: Album.find_by(name: name), personal_collection: self, time_created: DateTime.current())
    end

    def check_all_on_spotify
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")

        on_spot = []
        self.albums.each do |album|
            album.assign_onspotify
            if album.onspotify
                on_spot << album.full_notation
            end
        end
        if on_spot.empty?
            "Unfortunately none of the albums on #{self.name} are on Spotify."
        else
            str = "Good News! These albums are now on Spotify:\n"
            on_spot.each{|album| str.concat("#{album}\n")}
            str.concat("Happy listening!")
        end
    end
end