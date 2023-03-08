class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def recipes_proposal
    # @recipes_proposal = [recipe1, recipe2, recipe3]
  end

  def show_detailed
    @recipe = Recipe.find(params[:id])
  end
end
