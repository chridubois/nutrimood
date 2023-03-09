class InfosController < ApplicationController

  def show
    @condition = Condition.find_by(user: current_user)
    @recipe = Recipe.find(params[:id])

    @recipes3 = []

    while @recipes3.size == 3
      unless @recipes3.include?(ingredients_by_symptoms)
        @recipes3 << @recipe.ingredients_by_symptoms
      end
    end
    # 3.times do
    # @recipes3 << @recipe.ingredients_by_symptoms
    # end
  end

end
