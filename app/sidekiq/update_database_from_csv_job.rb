require 'csv'

class UpdateDatabaseFromCsvJob
  include Sidekiq::Job

  def perform
    # Création of only new ingredients
    p "Création des Ingredients"
    CSV.foreach(Rails.root.join('lib/ingredients.csv'), headers: true, :col_sep => ";") do |ingredient|
      if Ingredient.find_by(name: ingredient["name"]).nil?
        Ingredient.create({
          name: ingredient["name"]
        })
      end
    end

    # Création of ingredients/families
    p "Création des Families/Ingredients"
    CSV.foreach(Rails.root.join('lib/ingredients_by_family.csv'), headers: true, :col_sep => ";") do |item|
      ingredient = Ingredient.find_by(name: item["ingredient"])
      family = Family.find_by(name: item["family"])
      if family.nil?
        family = Family.create({
          name: item["family"]
        })
        if ingredient.nil?
          ingredient = Ingredient.create({
            name: item["ingredient"]
          })
        end
        IngredientsFamily.create({
          ingredient: ingredient,
          family: family
        })
      else
        if ingredient.nil?
          ingredient = Ingredient.create({
            name: item["ingredient"]
          })
        end
        ingredients_family = IngredientsFamily.find_by(ingredient: ingredient, family: family)
        if ingredients_family.nil?
          IngredientsFamily.create({
            ingredient: ingredient,
            family: family
          })
        end
      end
    end

    # Création of only new recipes
    p "Création des Recipes"
    CSV.foreach(Rails.root.join('lib/recipes.csv'), headers: true, :col_sep => ";") do |row|
      if Recipe.find_by(website_url: row["website_url"]).nil?
        recipe = Recipe.create({
          name: row["name"],
          calories_by_person: row["calories_by_person"].to_i,
          duration: row["duration"].to_i,
          image: row["image_url"],
          website_source: row["website_source"],
          website_url: row["website_url"]
        })
        # Création of ingredients by recipe
        p "Création des Ingredients de la recette"
        CSV.foreach(Rails.root.join('lib/recipe_ingredients.csv'), headers: true, :col_sep => ";") do |recipe_ingredient|
          if row["id"] == recipe_ingredient["recipe_id"]
            CSV.foreach(Rails.root.join('lib/ingredients.csv'), headers: true, :col_sep => ";") do |item|
              if recipe_ingredient["ingredient_id"] == item["id"]
                ingredient = Ingredient.find_by(name: item["name"])
              end
              unless ingredient.nil?
                RecipesIngredient.create({
                  recipe: recipe,
                  ingredient: ingredient,
                  unit: recipe_ingredient["unit"],
                  quantity: recipe_ingredient["quantity"].to_f
                })
              end
            end
          end
        end
        # Création of only new recipe steps
        p "Création des steps de la recette"
        CSV.foreach(Rails.root.join('lib/recipe_steps.csv'), headers: true, :col_sep => ";") do |step|
          if row["id"] == step["recipe_id"]
            RecipesStep.create({
              recipe: recipe,
              step_number: step["step_number"].to_i,
              step_description: step["step_description"]
            })
          end
        end
      end
    end
    # Création des moods
    p "Création des Moods"
    CSV.foreach(Rails.root.join('lib/moods.csv'), headers: true, :col_sep => ";") do |row|
      if Mood.where(name: row[0]).empty?
        Mood.create!({
          name: row[0],
          logo: row[1],
          description: row[2]
        })
        p row[0]
      end
    end

    # Création des symptomes
    p "Création des Symptom"
    CSV.foreach(Rails.root.join('lib/symptoms.csv'), headers: true) do |row|
      if Symptom.where(name: row[0]).empty?
        Symptom.create({
          name: row[0]
        })
      end
    end

    # Create real good Ingredients by symptom
    p "Création des vrais Ingredients by symptom"
    CSV.foreach(Rails.root.join('lib/ingredients_by_symptom.csv'), headers: true, :col_sep => ",") do |row|
      symptom = Symptom.where(name: row[0].downcase).first
      ingredient = Ingredient.where(name: row[1].downcase).first
      # p "Création de l'ingrédient #{row[0]} pour symptom: #{row[1]}"
      if !symptom.nil? && !ingredient.nil?
        p "Création de l'ingrédient #{ingredient.name} pour symptome:#{symptom.name}"
        if IngredientsBySymptom.where(symptom: symptom, ingredient: ingredient).empty?
          IngredientsBySymptom.create({
            symptom: symptom,
            ingredient: ingredient,
            anecdote: row[2],
            is_good: true,
            is_bad: false
          })
        end
      end
    end
    # Create real good Ingredients by mood
    p "Création des vrais Ingredients by mood"
    CSV.foreach(Rails.root.join('lib/ingredients_by_mood.csv'), headers: true, :col_sep => ";") do |row|
      mood = Mood.where(name: row[0].downcase).first
      ingredient = Ingredient.where(name: row[1].downcase).first
      p "Création de l'ingrédient #{mood} pour mood: #{ingredient}"
      if !mood.nil? && !ingredient.nil?
        # p "Création de l'ingrédient #{ingredient.name} pour mood: #{mood.name}"
        if IngredientsByMood.where(mood: mood, ingredient: ingredient).empty?
          IngredientsByMood.create({
            mood: mood,
            ingredient: ingredient,
            anecdote: row[2],
            is_good: row[3] == "true",
            is_bad: row[4] == "false"
          })
        end
      end
    end

    # Create real good Families by mood
    p "Création des vrais Families by mood"
    CSV.foreach(Rails.root.join('lib/families_by_mood.csv'), headers: true, :col_sep => ";") do |row|
      mood = Mood.where(name: row[0].downcase).first
      family = Family.where(name: row[1].downcase).first
      p "Création du mood #{mood} pour la famille: #{family}"
      if !mood.nil? && !family.nil?
        if FamiliesByMood.where(mood: mood, family: family).empty?
          FamiliesByMood.create({
            mood: mood,
            family: family,
            anecdote: row[2],
            is_good: row[3] == "true",
            is_bad: row[4] == "false"
          })
        end
      end
    end
  end
end
