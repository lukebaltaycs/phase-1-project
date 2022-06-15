class Link < ActiveRecord::Base
    belongs_to :user
    belongs_to :album

    before_create :site_equals

    def site_equals
        self[:site] = Link.parse_link_for_site(self[:info])
    end

    def self.parse_link_for_site(link_string)
        link_array = link_string.split(/[.\/]/)
        sites = ["youtube", "soundcloud", "tidal", "pandora", "amazon"]
        (link_array & sites).first
    end
    
end