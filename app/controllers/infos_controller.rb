class InfosController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
    if params[:cid]
      @condition = Condition.find(params[:cid])
    else
      @condition = Condition.where(user: current_user, recipe: @recipe).first
    end
  end
end
