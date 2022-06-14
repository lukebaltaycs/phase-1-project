class User < ActiveRecord::Base
    has_many :personal_collections


    def make_new_personal_collection(name)
        new_pc = PersonalCollection.create(name: name, user: self)
    end

    def add_album_to_personal_collection(album, personal_collection)
        AlbumCollect.create(album: album, personal_collection: personal_collection)
    end

end