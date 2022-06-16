
class AddLastFmClones < ActiveRecord::Migration[5.2]
    def change
        create_table :last_fm_clones do |t|
            t.integer :album_id
            t.string :name
            t.string :artist
            t.string :last_fm_url
            t.string :summary
        end
    end
end