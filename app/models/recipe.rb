class Recipe < ApplicationRecord
  has_many :recipes_steps
  has_many :recipes_ingredients
  has_many :conditions
  has_many :ingredients, through: :recipes_ingredients
  has_many :ingredients_by_symptoms, through: :ingredients

  validates :name, uniqueness: true

  def anecdotes(condition)
    @anecdotes = {}
    i = 1
    ingredients.each do |ingredient|
      ingredient_by_moods = IngredientsByMood.where(ingredient: ingredient, is_good: true, mood: condition.mood)
      ingredient_by_moods.each do |item|
        @anecdotes[i] = { ingredient: ingredient, anecdote: item.anecdote }
        i += 1
      end
    end

    @symptom_anecdotes = []
    symptoms = SymptomsByCondition.where(condition: condition)
    ingredients.each do |ingredient|
      symptoms.each do |symptom|
        ingredient_by_symptom = IngredientsBySymptom.where(ingredient: ingredient, is_good: true, symptom: symptom)
        ingredient_by_symptom.each do |item|
          @anecdotes[i] = { ingredient: ingredient, anecdote: item.anecdote }
          i += 1
        end
      end
    end

    return @anecdotes
  end
end
