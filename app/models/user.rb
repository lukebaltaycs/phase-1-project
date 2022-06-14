class User < ActiveRecord::Base
    has_many :personal_collections
    has_many :albums
end