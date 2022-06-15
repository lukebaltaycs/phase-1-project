class User < ActiveRecord::Base
    has_many :personal_collections
    has_many :links

    after_initialize :create_pc, if: :new_record?

    def create_pc
        new_pc = PersonalCollection.create(name: "My Personal Collection", user: self)
    end

    def make_new_personal_collection(name)
        new_pc = PersonalCollection.create(name: name, user: self)
    end

    def add_album_to_personal_collection(album, personal_collection)
        AlbumCollect.create(album: album, personal_collection: personal_collection, time_created: DateTime.current())
    end

    def save_album(album, personal_collection=self.personal_collections.find_by(name: "My Personal Collection"))
        add_album_to_personal_collection(album, personal_collection)
    end

    def save_album_by_name(name, personal_collection=self.personal_collections.find_by(name: "My Personal Collection"))
        self.save_album(Album.find_by(name: name), personal_collection)
    end

    def add_link(album, link_string)
        new_link = Link.new(user: self, album: album, info: link_string, valid: true, time_created: DateTime.current())
    end

end