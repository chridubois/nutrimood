require 'csv'

# Création des moods
Mood.destroy_all
Symptom.destroy_all
User.destroy_all
RecipesIngredient.destroy_all
RecipesStep.destroy_all
Ingredient.destroy_all
Recipe.destroy_all

# Création des moods
CSV.foreach(Rails.root.join('lib/moods.csv'), headers: false) do |row|
  p "Creating mood #{row[0]}"
  Mood.create({
    name: row[0]
  })
end

# Création des symptomes
CSV.foreach(Rails.root.join('lib/symptoms.csv'), headers: false) do |row|
  p "Creating symptom #{row[0]}"
  Symptom.create({
    name: row[0]
  })
end

# Création de users
CSV.foreach(Rails.root.join('lib/users.csv'), headers: true) do |row|
  p "Creating user #{row[9]}"
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
    gender: row[9]
  })
end

# Create recipes
i = 1

url = "https://recettehealthy.com/les-recette-salee/plat-complet/"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

#Get all recipes
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
  image = html_doc.search('.wprm-recipe-image img').attr('data-lazy-src').text

  # Get Recipe count of people
  count_people = html_doc.search('.wprm-recipe-servings').text.to_i

  # First creation of Recipe
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

    if Ingredient.find_by_name(name).nil?
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
