class Album < ActiveRecord::Base
    belongs_to :artist
    has_many :links
    has_many :album_collects
    has_many :personal_collections, through: :album_collects

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
        info << self.full_notation 
        self.return_album_links.each{|link| info << link}
        info
    end

    def self.find_by_name(name)
        Album.all.find_by(name: name)
    end

    def active_link_sites
        self.links.where(not_disputed: true).map{|link| link.site}
    end

    def link_is_invalid(link_site)
        if !Link.site_array.include?(link_site)
            print_sites = Link.site_array
            last_site = print_sites.pop
            string_to_return =  "The site you entered is invalid. Please enter " 
            print_sites.each{|site| string_to_return.concat("#{site.capitalize()}, ")}
            return string_to_return + "or #{last_site.capitalize()}."
        elsif !self.active_link_sites.include?(link_site)
            str = "#{self.full_notation} does not have an active link for the site #{link_site.capitalize()}. It's current active links are:\n"
            self.return_album_links.each{|link| str.concat("    #{link}\n")}
            return str
        end
        invalid_link = self.album_links.select{|link| link.site  == link_site}.first
        invalid_link.update_attribute(:not_disputed, false)
        invalid_link.save
    end

    def search_on_spotify 
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
        self.album_spotify_id = RSpotify::Album.search(self.name).first.id
    end

    def search_on_lastfm
        LastFM.api_key     = "227863264027c5a3c3408d22a1fe992d"
        LastFM.client_name = "Can I have access to the PI for a non-commercial school project?"

        LastFM::Album.get_info(:artist => self.artist.name, :album => self.name)
    end

    def tracks
        RSpotify::Album.find(self.album_spotify_id).tracks_cache.map{|track| track.name}
    end

    def assign_onspotify
        self.write_attribute(:onspotify, self.check_on_spotify_return)
    end

    def check_on_spotify_return
        initial = RSpotify::Album.search(self.name).select{|album| album.artists.first.name == self.artist.name}
        initial = nil
        if initial == nil
            return false 
        end
        secondary = initial.map{|album| album.name}
        if secondary == nil
            return false
        end
        secondary.include?(self.name)
    end

    def full_notation
        "'#{self.name}' by '#{self.artist.name}'"
    end

end