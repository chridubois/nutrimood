class InfosController < ApplicationController

  def show
    @condition = Condition.find_by(user: current_user)
    #la condition du user a était récup donc son mood id aussi ce dernier définira le choix des recettes
    #mais aussi le choix des ingredients => ingredient_by_mood
    @condition.mood_id = params[:mood]
  end

end
