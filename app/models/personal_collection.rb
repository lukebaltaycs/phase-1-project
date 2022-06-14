class PersonalCollection < ActiveRecord::Base
    belongs_to :user
    has_many :album_collects
    has_many :albums, through: :album_collects

    def albums
        self.album_collects.map{|collect| collect.album.name}
    end
    

end