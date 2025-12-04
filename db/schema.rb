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

ActiveRecord::Schema[8.1].define(version: 2025_12_02_170928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "countries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "journal_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "is_public"
    t.integer "nadmorska_visina"
    t.string "name"
    t.bigint "peak_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["peak_id"], name: "index_journal_entries_on_peak_id"
    t.index ["user_id"], name: "index_journal_entries_on_user_id"
  end

  create_table "journal_entry_reactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "journal_entry_id", null: false
    t.integer "type"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["journal_entry_id"], name: "index_journal_entry_reactions_on_journal_entry_id"
    t.index ["user_id"], name: "index_journal_entry_reactions_on_user_id"
  end

  create_table "peaks", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "lat"
    t.string "lon"
    t.string "name"
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_peaks_on_country_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "journal_entries", "peaks"
  add_foreign_key "journal_entries", "users"
  add_foreign_key "journal_entry_reactions", "journal_entries"
  add_foreign_key "journal_entry_reactions", "users"
  add_foreign_key "peaks", "countries"
end
