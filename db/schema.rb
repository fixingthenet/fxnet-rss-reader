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

ActiveRecord::Schema.define(version: 2021_02_29_052417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feed_status", force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
  end

  create_table "feed_subscriptions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "feed_id"
    t.bigint "user_id"
    t.index ["feed_id"], name: "index_feed_subscriptions_on_feed_id"
    t.index ["user_id"], name: "index_feed_subscriptions_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "name", null: false
    t.text "url", null: false
    t.datetime "last_fetched_at"
    t.integer "feed_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_success_at"
    t.integer "last_success_count"
    t.integer "last_failed_count"
    t.datetime "last_failed_at"
    t.index ["url"], name: "index_feeds_on_url", unique: true
  end

  create_table "oidc_open_ids", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "provider_id"
    t.string "identifier"
    t.string "access_token", limit: 2048
    t.string "id_token", limit: 2048
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_oidc_open_ids_on_provider_id"
    t.index ["user_id"], name: "index_oidc_open_ids_on_user_id"
  end

  create_table "providers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "issuer"
    t.string "jwks_uri"
    t.string "name"
    t.string "identifier"
    t.string "secret"
    t.string "scopes_supported"
    t.string "host"
    t.string "scheme"
    t.string "authorization_endpoint"
    t.string "token_endpoint"
    t.string "userinfo_endpoint"
    t.boolean "dynamic", default: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_providers_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.text "title"
    t.text "permalink"
    t.text "body"
    t.text "entry_id"
    t.integer "feed_id", null: false
    t.datetime "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permalink", "feed_id"], name: "index_stories_on_permalink_and_feed_id", unique: true
  end

  create_table "user_opens", force: :cascade do |t|
    t.datetime "last_opened_at"
    t.datetime "read_later_at"
    t.integer "user_id", null: false
    t.integer "story_id", null: false
    t.index ["read_later_at"], name: "index_user_opens_on_read_later_at"
    t.index ["user_id", "story_id"], name: "index_user_opens_on_user_id_and_story_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "feeds", "feed_status"
  add_foreign_key "stories", "feeds"
  add_foreign_key "user_opens", "stories"
  add_foreign_key "user_opens", "users"
end
