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

ActiveRecord::Schema.define(version: 2020_11_08_100053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "otps", force: :cascade do |t|
    t.string "phone", null: false
    t.string "password", null: false
    t.string "expiry", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phone"], name: "index_otps_on_phone"
  end

  create_table "products", force: :cascade do |t|
    t.text "title", null: false
    t.text "description", null: false
    t.text "image_url", null: false
    t.string "price"
    t.integer "product_type"
    t.string "provider", null: false
    t.string "provider_resource_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "resource_url"
    t.index ["provider_resource_id", "provider"], name: "index_products_on_provider_resource_id_and_provider", unique: true
    t.index ["title"], name: "index_products_on_title"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_ratings_on_product_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phone"], name: "index_users_on_phone"
  end

  add_foreign_key "ratings", "products"
  add_foreign_key "ratings", "users"
end
