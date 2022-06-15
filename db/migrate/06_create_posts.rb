class CreatePosts < ActiveRecord::Migration[5.2]
    def change
        create_table :posts do |t|
            t.integer :user_id
            t.datetime :time_created
            t.string :info
            t.boolean :valid
        end
    end
end