# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161215144535) do

  create_table "categories", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "films", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "idSuffix"
    t.string   "description"
    t.string   "location"
    t.string   "description2"
    t.date     "dateTaken"
    t.date     "dateEntered"
    t.string   "orientation"
    t.string   "keywords"
    t.string   "notes"
    t.integer  "lens_id"
    t.integer  "film_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "category_id"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.index ["category_id"], name: "index_images_on_category_id"
    t.index ["film_id"], name: "index_images_on_film_id"
    t.index ["lens_id"], name: "index_images_on_lens_id"
  end

  create_table "lenses", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "current_upload_file_file_name"
    t.string   "current_upload_file_content_type"
    t.integer  "current_upload_file_file_size"
    t.datetime "current_upload_file_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
