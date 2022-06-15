class Album < ActiveRecord::Base
    belongs_to :artist
    has_many :links
    has_many :album_collects
    has_many :personal_collections, through: :album_collects

    before_create :search_on_spotify

    def personal_collections
        self.album_collects.map{|collect| collect.personal_collection}
    end

    def album_links
        tl = self.links.where(not_disputed: true).order(:time_created).reverse()
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

    def link_is_invalid(link_site)
        invalid_link = self.album_links.select{|link| link.site  == "youtube"}.first
        invalid_link.update_attribute(:not_disputed, false)
        invalid_link.save
    end

    def search_on_spotify 
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
        self.album_spotify_id = RSpotify::Album.search(self.name).first.id
    end

    def spotify_attributes
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
        #url = "https://api.spotify.com/v1/albums/#{self.album_spotify_id}"
        #uri = URI.parse(url)
        #response = Net::HTTP.get_response(uri)
        #JSON.parse(response.body)
        RSpotify::Album.find(self.album_spotify_id)
    end

    def tracks
        RSpotify::Album.find(self.album_spotify_id).tracks_cache.map{|track| track.name}
    end

    def check_on_spotify
        RSpotify::Album.search(self.name).select{|album| album.artists.first.name == self.artist.name}.map{|album| album.name}.include?(self.name)
    end
end