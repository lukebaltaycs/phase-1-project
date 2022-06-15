class Album < ActiveRecord::Base
    belongs_to :artist
    has_many :links
    has_many :album_collects
    has_many :personal_collections, through: :album_collects

    def personal_collections
        self.album_collects.map{|collect| collect.personal_collection}
    end

    def links
        self.links.order(:time_created).where(valid: true)
    end


end