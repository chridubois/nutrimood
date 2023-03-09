class InfosController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def info1
    @ingredients_by_mood = IngredientByMood.find(params[:id])
    @ingredients_by_mood.anecdote = params[:anecdote]
  end

  def info2
    @ingredients_by_symptom = IngredientByMood.find(params[:id])
    @ingredients_by_symptom.anecdote = params[:anecdote]
  end

end
