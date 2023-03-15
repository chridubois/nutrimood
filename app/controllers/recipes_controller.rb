class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show show_detailed shop_list]

  def index
    @condition = Condition.find(params[:id])
    @good_ingredients = []
    @bad_ingredients = []
    # Get Good ingredients from Mood
    @good_ingredients_by_mood = IngredientsByMood.where(mood: @condition.mood, is_good: true)
    @good_ingredients_by_mood.each do |item|
      @good_ingredients << item.ingredient unless @good_ingredients.include?(item.ingredient)
    end
    # Get Bad ingredients from Mood
    @bad_ingredients_by_mood = IngredientsByMood.where(mood: @condition.mood, is_bad: true)
    @bad_ingredients_by_mood.each do |item|
      @bad_ingredients << item.ingredient unless @bad_ingredients.include?(item.ingredient)
    end
    # Get Good ingredients from Symptom
    @symptom_by_conditon = SymptomsByCondition.where(condition: @condition).to_a
    @symptom_by_conditon.each do |symptom_condition|

      @good_ingredients_by_symptom = IngredientsBySymptom.where(symptom_id: symptom_condition.symptom.id, is_good: true).to_a
      @good_ingredients_by_symptom.each do |item|
        @good_ingredients << item.ingredient unless @good_ingredients.include?(item.ingredient)
      end

      @bad_ingredients_by_symptom = IngredientsBySymptom.where(symptom_id: symptom_condition.symptom.id, is_bad: true).to_a
      @bad_ingredients_by_symptom.each do |item|
        @bad_ingredients << item.ingredient unless @bad_ingredients.include?(item.ingredient)
      end
    end

    # Get Ingredients restrictions from User
    @restrictions_ingredients = RestrictionsIngredientsUser.where(user: @current_user)
    @restrictions_ingredients.each do |item|
      @bad_ingredients << item.ingredient unless @bad_ingredients.include?(item.ingredient)
    end

    # Get Recipe already seen for the user
    @recipes_to_search = []
    @old_recipes = []
    @user_condition = Condition.where(user: current_user)
    @user_condition.each do |condition|
      @old_recipes << condition.recipe unless @old_recipes.include?(condition.recipe)
    end

    # Select recipes with calories less than condition_energy AND with duration less than 25min
    @recipes_query = Recipe.where("duration < ?", 100).where("calories_by_person < ?", 1000)
    @recipes_proposal = []
    @recipes_new = []

    # Select all recipes with good_ingredients
    @recipes_query.each do |recipe|
      @good_ingredients.each do |ingredient|
        @recipes_proposal << recipe if recipe.ingredients.to_a.include?(ingredient) && !@recipes_proposal.include?(recipe)
      end
    end

    # Exclude all recipes with bad_ingredients
    @recipes_proposal.each do |recipe|
      @bad_ingredients.each do |ingredient|
        @recipes_proposal.delete(recipe) if recipe.ingredients.to_a.include?(ingredient)
      end
    end

    # Exclude recipe already chosen
    @recipes_proposal.each do |recipe|
      @recipes_new << recipe unless @old_recipes.include?(recipe)
    end

    if @recipes_new.empty?
      @recipes_proposal = @recipes_proposal[0..2]
    else
      @recipes_proposal = @recipes_new[0..2]
    end
  end

  def show
  end

  def show_detailed
  end

  def shop_list
  end

  private

  def recipe_params
    params.require('recipe').permit(:name, :image, :complexity, :calories_by_person, :duration)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
