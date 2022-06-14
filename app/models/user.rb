class User < ActiveRecord::Base
    has_many :personal_collections


    def make_new_personal_collection(name)
        new_pc = PersonalCollection.new(name)
        new_pc.user = self       
    end

    def add_album_to_personal_collection(album, personal_collection)
        new_album_collect = AlbumCollect.new(album, personal_collection)
    end

end