class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def menu
    @recipes = []
    @conditions = Condition.where(user: current_user).order('created_at DESC')
    @conditions = @conditions.where.not(recipe_id: nil)
    @conditions.each do |condition|
      @recipes << condition.recipe
    end
    @recipes = @recipes[0..2]
  end
end
