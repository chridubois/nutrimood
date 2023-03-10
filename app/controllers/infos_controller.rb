class InfosController < ApplicationController

  def show
    @condition = Condition.find_by(user: current_user)
    @recipe = Recipe.find(params[:id])
  end
end
