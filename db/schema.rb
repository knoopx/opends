# encoding: UTF-8

ActiveRecord::Schema.define do
  create_table "artists", :force => true do |t|
    t.string "name"
    t.string "normalized_name"

    t.integer "play_count", :default => 0
    t.integer "tracks_count", :default => 0

    t.datetime "favorited_at"
    t.timestamps
  end

  create_table "artists_releases", :id => false, :force => true do |t|
    t.integer "artist_id"
    t.integer "release_id"
  end

  create_table "genres", :force => true do |t|
    t.string "name"
    t.timestamps
  end

  create_table "releases", :force => true do |t|
    t.string "name"
    t.string "title"
    t.string "path"
    t.string "year"

    t.integer "play_count", :default => 0
    t.integer "tracks_count", :default => 0

    t.boolean "various_artists", :default => false
    t.date "released_at"
    t.datetime "favorited_at"
    t.timestamps
  end

  create_table "sources", :force => true do |t|
    t.string "path"
    t.timestamps
  end

  create_table "tracks", :force => true do |t|
    t.integer "number"
    t.string "filename"
    t.string "title"
    t.string "length"
    t.string "year"
    t.string "sample_rate"
    t.string "bitrate"
    t.string "channels"
    t.string "size"

    t.integer "play_count", :default => 0

    t.integer "release_id"
    t.integer "artist_id"

    t.timestamps
  end
end
