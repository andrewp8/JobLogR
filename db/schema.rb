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

ActiveRecord::Schema[7.0].define(version: 2024_04_03_054834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ai_messages", force: :cascade do |t|
    t.text "role", default: [], array: true
    t.text "body", default: [], array: true
    t.bigint "job_listing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_ai_messages_on_job_listing_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "board_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.string "interview_type", null: false
    t.text "details"
    t.date "start_date"
    t.date "end_date"
    t.integer "point", default: 1, null: false
    t.bigint "job_listing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_interviews_on_job_listing_id"
  end

  create_table "job_listings", force: :cascade do |t|
    t.string "title", null: false
    t.string "company", null: false
    t.string "location"
    t.float "salary"
    t.integer "status", default: 0, null: false
    t.string "job_url"
    t.string "portal_url"
    t.text "details"
    t.string "details_summary"
    t.bigint "applicant_id", null: false
    t.integer "total_points", default: 0, null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_job_listings_on_applicant_id"
    t.index ["board_id"], name: "index_job_listings_on_board_id"
  end

  create_table "users", force: :cascade do |t|
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.citext "username"
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ai_messages", "job_listings"
  add_foreign_key "interviews", "job_listings"
  add_foreign_key "job_listings", "boards"
  add_foreign_key "job_listings", "users", column: "applicant_id"
end
