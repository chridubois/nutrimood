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

ActiveRecord::Schema[7.0].define(version: 2023_03_10_144834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.integer "energy_level"
    t.bigint "mood_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mood_id"], name: "index_conditions_on_mood_id"
    t.index ["user_id"], name: "index_conditions_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients_by_moods", force: :cascade do |t|
    t.string "anecdote"
    t.bigint "mood_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_good"
    t.boolean "is_bad"
    t.index ["ingredient_id"], name: "index_ingredients_by_moods_on_ingredient_id"
    t.index ["mood_id"], name: "index_ingredients_by_moods_on_mood_id"
  end

  create_table "ingredients_by_symptoms", force: :cascade do |t|
    t.bigint "symptom_id", null: false
    t.bigint "ingredient_id", null: false
    t.string "anecdote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_good"
    t.boolean "is_bad"
    t.index ["ingredient_id"], name: "index_ingredients_by_symptoms_on_ingredient_id"
    t.index ["symptom_id"], name: "index_ingredients_by_symptoms_on_symptom_id"
  end

  create_table "moods", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutrient_by_ingredients", force: :cascade do |t|
    t.bigint "nutrient_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_nutrient_by_ingredients_on_ingredient_id"
    t.index ["nutrient_id"], name: "index_nutrient_by_ingredients_on_nutrient_id"
  end

  create_table "nutrients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "complexity"
    t.integer "calories_by_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
  end

  create_table "recipes_ingredients", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.float "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipes_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipes_ingredients_on_recipe_id"
  end

  create_table "recipes_steps", force: :cascade do |t|
    t.integer "step_number"
    t.string "step_description"
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipes_steps_on_recipe_id"
  end

  create_table "restrictions_ingredients_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_restrictions_ingredients_users_on_ingredient_id"
    t.index ["user_id"], name: "index_restrictions_ingredients_users_on_user_id"
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "symptoms_by_conditions", force: :cascade do |t|
    t.bigint "condition_id", null: false
    t.bigint "symptom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["condition_id"], name: "index_symptoms_by_conditions_on_condition_id"
    t.index ["symptom_id"], name: "index_symptoms_by_conditions_on_symptom_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.date "birthday_date"
    t.integer "weight"
    t.integer "height"
    t.boolean "is_gluten_sensitive"
    t.boolean "is_diabetic"
    t.boolean "is_pregnant"
    t.string "gender"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "conditions", "moods"
  add_foreign_key "conditions", "users"
  add_foreign_key "ingredients_by_moods", "ingredients"
  add_foreign_key "ingredients_by_moods", "moods"
  add_foreign_key "ingredients_by_symptoms", "ingredients"
  add_foreign_key "ingredients_by_symptoms", "symptoms"
  add_foreign_key "nutrient_by_ingredients", "ingredients"
  add_foreign_key "nutrient_by_ingredients", "nutrients"
  add_foreign_key "recipes_ingredients", "ingredients"
  add_foreign_key "recipes_ingredients", "recipes"
  add_foreign_key "recipes_steps", "recipes"
  add_foreign_key "restrictions_ingredients_users", "ingredients"
  add_foreign_key "restrictions_ingredients_users", "users"
  add_foreign_key "symptoms_by_conditions", "conditions"
  add_foreign_key "symptoms_by_conditions", "symptoms"
end
