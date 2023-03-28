class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show show_detailed shop_list]

  def index
    @condition = Condition.find(params[:id])
    @good_ingredients = []
    @bad_ingredients = []
    # Get Good families from Mood
    @good_families_by_mood = FamiliesByMood.where(mood: @condition.mood, is_good: true).includes([:family, :ingredients])
    @good_families_by_mood.each do |family_mood|
      family_mood.ingredients.each do |ingredient|
        @good_ingredients << ingredient unless @good_ingredients.include?(ingredient)
      end
    end
    # Get Bad families from Mood
    @bad_families_by_mood = FamiliesByMood.where(mood: @condition.mood, is_bad: true).includes([:family, :ingredients])
    @bad_families_by_mood.each do |family_mood|
      family_mood.ingredients.each do |ingredient|
        @bad_ingredients << ingredient unless @bad_ingredients.include?(ingredient)
      end
    end
    # Get Good ingredients from Mood
    @good_ingredients_by_mood = IngredientsByMood.where(mood: @condition.mood, is_good: true).includes([:ingredient])
    @good_ingredients_by_mood.each do |item|
      @good_ingredients << item.ingredient unless @good_ingredients.include?(item.ingredient)
    end
    # Get Bad ingredients from Mood
    @bad_ingredients_by_mood = IngredientsByMood.where(mood: @condition.mood, is_bad: true).includes([:ingredient])
    @bad_ingredients_by_mood.each do |item|
      @bad_ingredients << item.ingredient unless @bad_ingredients.include?(item.ingredient)
    end
    # Get Good ingredients from Symptom
    @symptom_by_conditon = SymptomsByCondition.where(condition: @condition).to_a
    @symptom_by_conditon.each do |symptom_condition|

      @good_families_by_symptom = FamiliesBySymptom.where(symptom_id: symptom_condition.symptom.id, is_good: true).includes([:family, :ingredients])
      @good_families_by_symptom.each do |family_symptom|
        family_symptom.ingredients.each do |ingredient|
          @good_ingredients << ingredient unless @good_ingredients.include?(ingredient)
        end
      end

      @bad_families_by_symptom = FamiliesBySymptom.where(symptom_id: symptom_condition.symptom.id, is_bad: true).includes([:family, :ingredients])
      @bad_families_by_symptom.each do |family_symptom|
        family_symptom.ingredients.each do |ingredient|
          @bad_ingredients << ingredient unless @bad_ingredients.include?(ingredient)
        end
      end

      @good_ingredients_by_symptom = IngredientsBySymptom.where(symptom_id: symptom_condition.symptom.id, is_good: true).includes([:ingredient]).to_a
      @good_ingredients_by_symptom.each do |item|
        @good_ingredients << item.ingredient unless @good_ingredients.include?(item.ingredient)
      end

      @bad_ingredients_by_symptom = IngredientsBySymptom.where(symptom_id: symptom_condition.symptom.id, is_bad: true).includes([:ingredient]).to_a
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
    @user_condition = Condition.where(user: current_user).includes([:recipe])
    @user_condition.each do |condition|
      @old_recipes << condition.recipe unless @old_recipes.include?(condition.recipe)
    end

    # Select recipes with calories less than condition_energy AND with duration less than 25min
    @recipes_query = Recipe.where("duration < ?", 100).where("calories_by_person < ?", 1000).includes([:ingredients])
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
      @recipe_sorted = {}
      @recipes_new.each do |recipe|
        @recipe_sorted[recipe] = recipe.anecdotes_number(@condition)
      end
      @recipes_new = @recipe_sorted.sort_by { |_key, value| -value }.to_h

      @recipes_proposal = @recipes_new.keys[0..2]
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
    params.require('recipe').permit(:name, :image, :complexity, :calories_by_person, :duration, :website_source, :website_url)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
