class Album < ActiveRecord::Base
    belongs_to :artist
    #has_many :album_collects
    #has_many :personal_collections, through: :album_collects

end