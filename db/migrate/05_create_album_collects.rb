class CreateAlbumCollects < ActiveRecord::Migration[5.2]
    
    def change
        create_table :album_collects do |t|
            t.integer :personal_collection_id
            t.integer :album_id
            t.datetime :time_created
        end
    end
end