class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def menu
    @conditions = Condition.where(user: current_user)
    @recipes = Recipe.all.limit(3)
  end
end
