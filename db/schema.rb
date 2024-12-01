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

ActiveRecord::Schema[8.1].define(version: 2024_12_01_052830) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "month"
    t.integer "year"
    t.decimal "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "crypto_prices", force: :cascade do |t|
    t.string "crypto_id"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "symbol"
    t.decimal "market_cap"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.decimal "target_amount"
    t.decimal "current_amount"
    t.date "deadline"
    t.boolean "achieved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "lot_details", force: :cascade do |t|
    t.bigint "lot_id", null: false
    t.string "venue"
    t.string "quantity"
    t.string "unit"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_lot_details_on_lot_id"
  end

  create_table "lots", force: :cascade do |t|
    t.bigint "notice_id", null: false
    t.string "lot_number"
    t.string "min_price"
    t.string "lot_type"
    t.string "status"
    t.string "person"
    t.string "errata_warnings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notice_id"], name: "index_lots_on_notice_id"
  end

  create_table "notices", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lots_count"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount"
    t.bigint "category_id", null: false
    t.string "description"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "budgets", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "lot_details", "lots"
  add_foreign_key "lots", "notices"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "users"
end
