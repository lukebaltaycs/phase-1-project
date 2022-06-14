class CreateAlbumCollects < ActiveRecord::Migration[5.2]
    
    def changes
        create_table :album_collects do |t|
            t.timestamp
        end
    end
end