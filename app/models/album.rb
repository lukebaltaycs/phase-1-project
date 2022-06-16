class Album < ActiveRecord::Base
    belongs_to :artist
    has_many :links
    has_many :last_fm_clones
    has_many :album_collects
    has_many :personal_collections, through: :album_collects

    def add_last_fm_clone
        lfc = LastFmClone.create(album: self)
        info = self.search_on_lastfm
        lfc.name = info["name"]
        lfc.artist = info["artist"]
        lfc.last_fm_url = info["url"]
        lfc.summary = info["wiki"]["content"]
        self.last_fm_clones << lfc
        lfc.save
    end

    def check_name_on_lastfm
        lastfm = Lastfm.new("227863264027c5a3c3408d22a1fe992d", "2d1e640d3a44317c1ca713516f822727")
        self.update_attribute(:name, lastfm.album.search(album: self.name)["results"]["albummatches"].first[1].find{|album| album["artist"] = self.artist}["name"])
        #if lastfm.album.search(album: self.name)["results"]["albummatches"].first[1][0]["url"] != self.last_fm_clone.last_fm_url
        self.save
        #self.artist.check_name_on_lastfm
        #(lastfm.artist.get_top_albums(artist: self.artist.name) & lastfm.album.search(album: self.name)["results"]["albummatches"].first[1])
    end

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
        lastfm = Lastfm.new("227863264027c5a3c3408d22a1fe992d", "2d1e640d3a44317c1ca713516f822727")
        lastfm.album.get_info(artist: self.artist.name, album: self.name)
    end

    def tracks
        RSpotify::Album.find(self.album_spotify_id).tracks_cache.map{|track| track.name}
    end

    def assign_onspotify
        self.write_attribute(:onspotify, self.check_on_spotify_return)
        self.save
    end

    def render_name_plain
        self.name.downcase.gsub(/\W/, '')
    end

    def check_name_on_spotify
        initial = RSpotify::Album.search(self.name)
        #.map{|album| album.name.lowercase.gsub(/\W/, '')}
        initial.each do |album|
            if album.name.downcase.gsub(/\W/, '') == self.render_name_plain && album.artists.first.name == self.artist.name
                self.write_attribute(:name, album.name)
            end
        end
        self.save
        self.assign_onspotify
    end

    def check_on_spotify_return
        initial = RSpotify::Album.search(self.name).select{|album| album.artists.first.name == self.artist.name}
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