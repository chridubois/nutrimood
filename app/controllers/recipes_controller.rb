class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show show_detailed]

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
    # Select all recipes
    @recipes = Recipe.all
    @recipe_proposal = []

    # Select all recipes with good_ingredients
    @recipes.each do |recipe|
      @good_ingredients.each do |ingredient|
        @recipe_proposal << recipe if recipe.ingredients.include?(ingredient) && !@recipe_proposal.include?(recipe)
      end
    end

    # Exclude all recipes with bad_ingredients
    @recipe_proposal.each do |recipe|
      @bad_ingredients.each do |ingredient|
        @recipe_proposal.delete(recipe) if recipe.ingredients.include?(ingredient)
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def show_detailed
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require('recipe').permit(:name, :image, :complexity, :calories_by_person, :duration)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
