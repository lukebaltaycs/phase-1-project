class CreateAlbumCollects < ActiveRecord::Migration[5.2]
    
    def change
        create_table :album_collects do |t|
            t.timestamp :time_created
        end
    end
end