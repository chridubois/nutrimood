class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.limit(3)
  end

  def show

  end

  def show_detailed
    @recipe = Recipe.find(params[:id])
  end
end
