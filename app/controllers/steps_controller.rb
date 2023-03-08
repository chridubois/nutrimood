class StepsController < ApplicationController
  def index
    @recipe = Recipe.find(params[:id])
    @steps = @recipe.recipes_steps
  end
end
