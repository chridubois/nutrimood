class Recipe < ApplicationRecord
  has_many :recipes_steps
  has_many :recipes_ingredients
  has_many :conditions
  has_many :ingredients, through: :recipes_ingredients
  has_many :ingredients_by_symptoms, through: :ingredients
  has_many :ingredients_by_moods, through: :ingredients
  has_many :ingredients_families, through: :ingredients
  has_many :families, through: :ingredients_families
  has_many :families_by_symptoms, through: :families
  has_many :families_by_moods, through: :families

  validates :name, uniqueness: true

  def anecdotes(condition)
    @anecdotes = {}
    unique_ingredients = []
    i = 1
    ingredients.to_a.each do |ingredient|
      ingredient_by_moods = IngredientsByMood.where(ingredient: ingredient, is_good: true, mood: condition.mood).to_a
      ingredient_by_moods.each do |item|
        unless unique_ingredients.include?(ingredient)
          @anecdotes[i] = { ingredient: ingredient, anecdote: item.anecdote }
          unique_ingredients << ingredient
        end
        i += 1
      end
      ingredient.families.each do |family|
        families_by_moods = FamiliesByMood.where(family: family, is_good: true, mood: condition.mood).to_a
        families_by_moods.each do |item|
          unless unique_ingredients.include?(item.family)
            @anecdotes[i] = { family: item.family, anecdote: item.anecdote }
            unique_ingredients << item.family
          end
          i += 1
        end
      end
    end

    @symptom_anecdotes = []
    symptoms_by_conditions = SymptomsByCondition.where(condition: condition).to_a
    ingredients.to_a.each do |ingredient|
      symptoms_by_conditions.each do |symptoms_by_condition|
        ingredient_by_symptom = IngredientsBySymptom.where(ingredient: ingredient, is_good: true, symptom: symptoms_by_condition.symptom).to_a
        ingredient_by_symptom.each do |item|
          unless unique_ingredients.include?(ingredient)
            @anecdotes[i] = { ingredient: ingredient, anecdote: item.anecdote }
            unique_ingredients << ingredient
          end
          i += 1
        end
        ingredient.families.each do |family|
          families_by_symptom = FamiliesBySymptom.where(family: family, is_good: true, symptom: symptoms_by_condition.symptom).to_a
          families_by_symptom.each do |item|
            unless unique_ingredients.include?(item.family)
              @anecdotes[i] = { family: item.family, anecdote: item.anecdote }
              unique_ingredients << item.family
            end
            i += 1
          end
        end
      end
    end
    return @anecdotes
  end

  def anecdotes_number(condition)
    return anecdotes(condition).count
  end
end
