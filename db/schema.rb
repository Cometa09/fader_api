ActiveRecord::Schema[7.0].define(version: 2025_04_03_153313) do
  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preset_settings", force: :cascade do |t|
    t.integer "preset_id", null: false
    t.integer "element_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_preset_settings_on_element_id"
    t.index ["preset_id"], name: "index_preset_settings_on_preset_id"
  end

  create_table "presets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_presets_on_user_id"
  end

  create_table "configurations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_configurations_on_user_id"
  end

  create_table "elements", force: :cascade do |t|
    t.integer "element_type", default: 0, null: false
    t.integer "x_position"
    t.integer "y_position"
    t.integer "width"
    t.integer "height"
    t.string "label"
    t.integer "control_function"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "target_type", null: false
    t.integer "target_id"
    t.string "status"
    t.index ["target_type", "target_id"], name: "index_elements_on_target_type_and_target_id"
  end

  create_table "configuration_elements", force: :cascade do |t|
    t.integer "element_type", null: false
    t.integer "x_position"
    t.integer "y_position"
    t.integer "width"
    t.integer "height"
    t.string "label"
    t.integer "control_function"
    t.integer "target_type", null: false
    t.integer "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "configuration_id"
  end

  create_table "faders", force: :cascade do |t|
    t.integer "element_id"
    t.integer "value"
    t.integer "min_value"
    t.integer "max_value"
    t.integer "default_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buttons", force: :cascade do |t|
    t.integer "element_id", null: false
    t.string "image_path"
    t.string "status", default: "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_buttons_on_element_id"
  end

  create_table "knobs", force: :cascade do |t|
    t.integer "element_id", null: false
    t.integer "default_value"
    t.integer "value"
    t.integer "min_value"
    t.integer "max_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_knobs_on_element_id"
  end

  create_table "displays", force: :cascade do |t|
    t.integer "element_id", null: false
    t.string "display_type"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_displays_on_element_id"
  end

  create_table "meters", force: :cascade do |t|
    t.integer "element_id", null: false
    t.string "meter_type"
    t.integer "current_level"
    t.integer "peak_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_meters_on_element_id"
  end

  create_table "eq_sliders", force: :cascade do |t|
    t.integer "element_id"
    t.integer "frequency_band"
    t.integer "default_value"
    t.integer "value"
    t.integer "min_value"
    t.integer "max_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channel_group_mappings", force: :cascade do |t|
    t.integer "channel_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_group_mappings_on_channel_id"
    t.index ["group_id"], name: "index_channel_group_mappings_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outputs", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buttons", "elements"
  add_foreign_key "channel_group_mappings", "channels"
  add_foreign_key "channel_group_mappings", "groups"
  add_foreign_key "configuration_elements", "configurations", on_delete: :nullify
  add_foreign_key "configurations", "users"
  add_foreign_key "displays", "elements"
  add_foreign_key "knobs", "elements"
  add_foreign_key "meters", "elements"
  add_foreign_key "preset_settings", "elements"
  add_foreign_key "preset_settings", "presets"
  add_foreign_key "presets", "users"
end
