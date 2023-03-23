require 'csv'

# Reset des tables
p "Reset des tables"
# SymptomsByCondition.destroy_all
# Condition.destroy_all
# RestrictionsIngredientsUser.destroy_all
# User.destroy_all


# Création de users
p "Création des users"
CSV.foreach(Rails.root.join('lib/users.csv'), headers: true) do |row|
  User.create({
    email: row[0],
    password: row[1],
    firstname: row[2],
    birthday_date: row[3],
    weight: row[4],
    height: row[5],
    is_gluten_sensitive: row[6],
    is_diabetic: row[7],
    is_pregnant: row[8],
    gender: row[9],
    admin: true
  })
end

# Create user ingredient restrictions
p "Création des User restrictions"
ingredient_count = Ingredient.count
mood_count = Mood.count
symptom_count = Symptom.count
user_count = User.count
recipe_count = Recipe.count

User.all.each do |user|
  random_ingredient_offset = rand(ingredient_count)
  random_ingredient = Ingredient.offset(random_ingredient_offset).first
  RestrictionsIngredientsUser.create({
    user: user,
    ingredient: random_ingredient
  })
end

# Create user conditions
# p "Création des conditions"
# 10.times do
#   random_mood_offset = rand(mood_count)
#   random_mood = Mood.offset(random_mood_offset).first
#   random_user_offset = rand(user_count)
#   random_user = User.offset(random_user_offset).first
#   random_recipe_offset = rand(recipe_count)
#   random_recipe = Recipe.offset(random_recipe_offset).first
#   Condition.create({
#     user: random_user,
#     mood: random_mood,
#     recipe: random_recipe,
#     energy_level: [25, 50, 75, 100].sample
#   })
# end

# Create Symptom by condition
# p "Création des Symptom by condition"
# Condition.all.each do |condition|
#   2.times do
#     random_symptom_offset = rand(symptom_count)
#     random_symptom = Symptom.offset(random_symptom_offset).first
#     SymptomsByCondition.create({
#       symptom: random_symptom,
#       condition: condition
#     })
#   end
# end

# Create fake Ingredients by symptom
p "Création des Ingredients by symptom"
Symptom.all.each do |symptom|
  # Create bad ingredients
  3.times do
    random_ingredient_offset = rand(ingredient_count)
    random_ingredient = Ingredient.offset(random_ingredient_offset).first
    IngredientsBySymptom.create({
      symptom: symptom,
      ingredient: random_ingredient,
      anecdote: "Manger #{random_ingredient.name} est à proscrire pour le symptôme #{symptom.name}",
      is_good: false,
      is_bad: true
    })
  end
end

# Create fake Ingredients by mood
p "Création des Ingredients by mood"
Mood.all.each do |mood|
  # Create bad ingredients
  3.times do
    random_ingredient_offset = rand(ingredient_count)
    random_ingredient = Ingredient.offset(random_ingredient_offset).first
    IngredientsByMood.create({
      mood: mood,
      ingredient: random_ingredient,
      anecdote: "Manger #{random_ingredient.name} est très bon pour le mood #{mood.name}",
      is_good: false,
      is_bad: true
    })
  end

  # Create good ingredients
  3.times do
    random_ingredient_offset = rand(ingredient_count)
    random_ingredient = Ingredient.offset(random_ingredient_offset).first
    IngredientsByMood.create({
      mood: mood,
      ingredient: random_ingredient,
      anecdote: "Manger #{random_ingredient.name} est très mauvais pour le mood #{mood.name}",
      is_good: false,
      is_bad: true
    })
  end
end
