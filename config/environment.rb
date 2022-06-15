require 'bundler'
Bundler.require

require 'rspotify'
require 'open-uri'
require 'net/http'
require 'json'


require_all "app/models"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'



