# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_02_215731) do

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "event_photo"
    t.string "description"
    t.string "location"
    t.datetime "time"
    t.integer "event_organizer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invite_statuses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "invites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.integer "invite_status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_invites_on_event_id"
    t.index ["invite_status_id"], name: "index_invites_on_invite_status_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "invites", "events"
  add_foreign_key "invites", "invite_statuses"
  add_foreign_key "invites", "users"
end
