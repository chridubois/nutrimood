class RecipesController < ApplicationController
  def index
    @condition = Condition.find_by(user: current_user)
    @good_ingredients = []
    @bad_ingredients = []
    # Get Good ingredients from Mood
    @good_ingredients_by_mood = IngredientsByMood.where(mood: @condition.mood, is_good: true)
    @good_ingredients_by_mood.each do |item|
      @good_ingredients << item.ingredient
    end
    # Get Bad ingredients from Mood
    @bad_ingredients_by_mood = IngredientsByMood.where(mood: @condition.mood, is_bad: true)
    @bad_ingredients_by_mood.each do |item|
      @bad_ingredients << item.ingredient
    end
    # Get Good ingredients from Symptom
    @symptom_by_conditon = SymptomsByCondition.where(condition: @condition)
    @symptom_by_conditon.each do |symptom|
      @good_ingredients_by_symptom = IngredientsBySymptom.where(symptom: symptom, is_good: true)
      @good_ingredients_by_symptom.each do |item|
        @good_ingredients << item.ingredient
      end
      @bad_ingredients_by_symptom = IngredientsBySymptom.where(symptom: symptom, is_bad: true)
      @bad_ingredients_by_symptom.each do |item|
        @bad_ingredients << item.ingredient
      end
    end
    @recipes = Recipe.all.limit(3)
  end

  def show
  end

  def show_detailed
    @recipe = Recipe.find(params[:id])
  end
end
