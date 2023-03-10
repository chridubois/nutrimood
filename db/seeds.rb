require 'csv'

# Reset des tables
p "Reset des tables"
SymptomsByCondition.destroy_all
Condition.destroy_all
RestrictionsIngredientsUser.destroy_all
IngredientsBySymptom.destroy_all
IngredientsByMood.destroy_all
Mood.destroy_all
Symptom.destroy_all
User.destroy_all
RecipesIngredient.destroy_all
RecipesStep.destroy_all
Ingredient.destroy_all
Recipe.destroy_all

# Création des moods
p "Création des Moods"
CSV.foreach(Rails.root.join('lib/moods.csv'), headers: false) do |row|
  Mood.create({
    name: row[0]
  })
end

# Création des symptomes
p "Création des Symptom"
CSV.foreach(Rails.root.join('lib/symptoms.csv'), headers: false) do |row|
  Symptom.create({
    name: row[0]
  })
end

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

# Create recipes
pages_count = 1

while pages_count < 24
  url = "https://recettehealthy.com/les-recette-salee/plat-complet/page/#{pages_count}/"
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML.parse(html_file)

  # Get all recipes
  p "Création des Recettes page #{pages_count}"
  recipe_urls = html_doc.xpath('//article//a/@href').map {|attr| attr.value}

  recipe_urls.each do |url|
    # For each recipe, get recipe infos
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)

    # Get Recipe name
    name = html_doc.search('.wprm-recipe-container h2').text

    # Get Recipe prep_time
    prep_time = html_doc.search('.wprm-recipe-details.wprm-recipe-details-minutes.wprm-recipe-prep_time.wprm-recipe-prep_time-minutes').text.to_i

    # Get Recipe cook_time
    cook_time = html_doc.search('.wprm-recipe-details.wprm-recipe-details-minutes.wprm-recipe-cook_time.wprm-recipe-cook_time-minutes').text.to_i

    # Get Recipe calories
    calories = html_doc.search('.wprm-recipe-details.wprm-recipe-nutrition.wprm-recipe-calories.wprm-block-text-normal').text.to_i

    # Get Recipe image
    next if html_doc.search('.wprm-recipe-image img').attr('data-lazy-src').nil?

    image = html_doc.search('.wprm-recipe-image img').attr('data-lazy-src').text

    # Get Recipe count of people
    count_people = html_doc.search('.wprm-recipe-servings').text.to_i

    # First creation of Recipe
    if Recipe.find_by(name: name).nil?
      recipe = Recipe.create({
        name: name,
        calories_by_person: calories,
        duration: prep_time + cook_time,
        image: image
      })

      # Get Recipe Ingredients
      ingredients = html_doc.search('li.wprm-recipe-ingredient')
      i = 0
      ingredients.each do |ingredient|
        quantity = ingredient.xpath('//span[@class="wprm-recipe-ingredient-amount"]').collect(&:text)[i].to_i
        quantity_calc = (quantity / count_people.to_f).ceil(2)
        unit = ingredient.xpath('//span[@class="wprm-recipe-ingredient-unit"]').collect(&:text)[i]
        name = ingredient.xpath('//span[@class="wprm-recipe-ingredient-name"]').collect(&:text)[i]

        if Ingredient.find_by(name: name).nil?
          ingredient = Ingredient.create({
            name: name
          })
        else
          ingredient = Ingredient.find_by_name(name)
        end

        RecipesIngredient.create({
          recipe: recipe,
          ingredient: ingredient,
          unit: unit,
          quantity: quantity_calc
        })
        i += 1
      end

      # Get Recipe steps
      steps = html_doc.search('li.wprm-recipe-instruction')
      i = 0
      steps.each do |step|
        RecipesStep.create({
          recipe: recipe,
          step_number: i + 1,
          step_description: step.text
        })
        i += 1
      end
    end
  end
  pages_count += 1
end
# Create user ingredient restrictions
p "Création des User restrictions"
ingredient_count = Ingredient.count
mood_count = Mood.count
symptom_count = Symptom.count
user_count = User.count

User.all.each do |user|
  random_ingredient_offset = rand(ingredient_count)
  random_ingredient = Ingredient.offset(random_ingredient_offset).first
  RestrictionsIngredientsUser.create({
    user: user,
    ingredient: random_ingredient
  })
end

# Create user conditions
p "Création des conditions"
40.times do
  random_mood_offset = rand(mood_count)
  random_mood = Mood.offset(random_mood_offset).first
  random_user_offset = rand(user_count)
  random_user = User.offset(random_user_offset).first
  Condition.create({
    user: random_user,
    mood: random_mood,
    # symptom: random_symptom,
    energy_level: [25, 50, 75, 100].sample
  })
end

# Create Symptom by condition
p "Création des Symptom by condition"
Condition.all.each do |condition|
  2.times do
    random_symptom_offset = rand(symptom_count)
    random_symptom = Symptom.offset(random_symptom_offset).first
    SymptomsByCondition.create({
      symptom: random_symptom,
      condition: condition
    })
  end
end

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

  # Create good ingredients
  3.times do
    random_ingredient_offset = rand(ingredient_count)
    random_ingredient = Ingredient.offset(random_ingredient_offset).first
    IngredientsBySymptom.create({
      symptom: symptom,
      ingredient: random_ingredient,
      anecdote: "Manger #{random_ingredient.name} vous guérit immédiatement du symptôme #{symptom.name}",
      is_good: true,
      is_bad: false
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
      is_good: true,
      is_bad: false
    })
  end
end
