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

ActiveRecord::Schema[7.1].define(version: 2023_12_25_023137) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "brand_name"
    t.string "brand_logo"
    t.text "brand_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "model_brand"
    t.string "model_title_name"
    t.string "model_price"
    t.string "model_segment"
    t.string "model_main_pic"
    t.string "model_engine"
    t.string "model_power"
    t.string "model_torque"
    t.string "model_gearbox"
    t.string "model_drive_system"
    t.integer "model_seat"
    t.string "model_type"
    t.string "model_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "model_price_min"
    t.integer "model_price_max"
    t.integer "brand_id"
    t.integer "type_id"
    t.integer "segment_id"
    t.text "model_desc"
    t.integer "model_year"
    t.string "model_name_main"
  end

  create_table "segments", force: :cascade do |t|
    t.string "segment_name"
    t.text "segment_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "type_name"
    t.string "type_image"
    t.text "type_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "models", "brands"
  add_foreign_key "models", "segments"
  add_foreign_key "models", "types"
end
