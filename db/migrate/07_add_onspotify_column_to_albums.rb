class AddOnspotifyColumnToAlbums < ActiveRecord::Migration[5.2]
    def change
        add_column :albums, :onspotify, :boolean
    end
end