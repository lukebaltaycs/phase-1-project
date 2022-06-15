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


end