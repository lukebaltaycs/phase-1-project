class CreateAlbumCollects < ActiveRecord::Migration[5.2]
    def changes
        create_table :album_collects do |t|
            t.integer :album_id
            t.integer :personal_collection_id
        end
    end
end