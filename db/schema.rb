# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 8) do
  create_table "album_collects", force: :cascade do |t|
    t.integer "personal_collection_id"
    t.integer "album_id"
    t.datetime "time_created", precision: nil
  end

  create_table "albums", force: :cascade do |t|
    t.integer "artist_id"
    t.string "name"
    t.string "album_spotify_id"
    t.boolean "onspotify"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "artist_spotify_id"
  end

  create_table "last_fm_clones", force: :cascade do |t|
    t.integer "album_id"
    t.string "name"
    t.string "artist"
    t.string "last_fm_url"
    t.string "summary"
  end

  create_table "links", force: :cascade do |t|
    t.integer "user_id"
    t.integer "album_id"
    t.datetime "time_created", precision: nil
    t.string "info"
    t.string "site"
    t.boolean "not_disputed"
  end

  create_table "personal_collections", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
