class CreateLinks < ActiveRecord::Migration[5.2]
    def change
        create_table :links do |t|
            t.integer :user_id
            t.integer :album_id
            t.datetime :time_created
            t.string :info
            t.boolean :not_disputed
        end
    end
end