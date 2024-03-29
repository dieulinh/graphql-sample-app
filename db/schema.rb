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

ActiveRecord::Schema.define(version: 2022_04_11_115735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "attached_photos", force: :cascade do |t|
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_attachments", force: :cascade do |t|
    t.bigint "course_id"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.text "description"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "email"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "section_order"
    t.integer "course_id"
    t.index ["course_id"], name: "index_posts_on_course_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_login"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "roles", default: [], array: true
    t.index ["roles"], name: "index_students_on_roles", using: :gin
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "title"
    t.text "teaching_experience"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
