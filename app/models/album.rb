class Album < ActiveRecord::Base
    belongs_to :artist
    has_many :links
    has_many :album_collects
    has_many :personal_collections, through: :album_collects

    def personal_collections
        self.album_collects.map{|collect| collect.personal_collection}
    end

    def album_links
        tl = self.links.where(not_disputed: true).order(:time_created)
        array = []
        tl.each do |link|
            if !array.map{|link| link.site}.any?(link.site)
                array << link
            end
        end
        array
    end

    def return_album_links
        link_array = []
        self.album_links.each do |link|
            link_array << "#{link.site.capitalize()}: #{link.info}"
        end
        link_array
    end

    def return_album_info
        info = []
        info << "#{self.name} by #{self.artist.name}" 
        self.return_album_links.each{|link| info << link}
        info
    end

    def self.find_by_name(name)
        Album.all.find_by(name: name)
    end

end