class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show show_detailed shop_list]

  def index
    @condition = Condition.find(params[:id])
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

    # Get Recipe already seen for the user
    @recipes_to_search = []
    @old_recipes = []
    @user_condition = Condition.where(user: current_user)
    @user_condition.each do |condition|
      @old_recipes << condition.recipe unless @old_recipes.include?(condition.recipe)
    end

    # Select recipes with calories less than condition_energy AND with duration less than 25min
    @recipes_fast = Recipe.where("duration < ?", 50)
    @recipess = @recipes_fast.where("calories_by_person < ?", 1000)
    @recipe_proposal = []
    @recipe_final = []

    # Exclude recipes already seen by the user
    # if @old_recipes.first.nil?
    #   @recipes = @recipess
    # else
    #   @recipes = @recipess.to_a.reject! { |recipe| @old_recipes.include?(recipe) }
    # end

    @recipess.each do |recipe|
      @recipe_proposal << recipe unless @old_recipes.include?(recipe)
    end

    # Select all recipes with good_ingredients
    @recipe_proposal.each do |recipe|
      @good_ingredients.each do |ingredient|
        @recipe_final << recipe if recipe.ingredients.include?(ingredient) && !@recipe_proposal.include?(recipe)
      end
    end

    # Exclude all recipes with bad_ingredients
    @recipe_proposal.each do |recipe|
      @bad_ingredients.each do |ingredient|
        @recipe_final.delete(recipe) if recipe.ingredients.include?(ingredient)
      end
    end
    @recipe_final = @recipe_final[0..2]
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
