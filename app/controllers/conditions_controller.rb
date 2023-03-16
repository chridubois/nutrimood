class ConditionsController < ApplicationController
  before_action :set_cache_headers, only: %i[list_moods list_symptoms]

  def list_moods
    @moods = Mood.all
  end

  def list_energy
    @condition = Condition.find(params[:id])
  end

  def list_symptoms
    @symptoms = Symptom.all
    @condition = Condition.find(params[:id])
  end

  def recap
    @condition = Condition.where(user: current_user).last
  end

  def create_condition
    @mood_id = params[:mood_id]
    @condition = Condition.new(mood_id: @mood_id, user: current_user)
    if @condition.save!
      redirect_to list_energy_path + "?id=#{@condition.id}"
    else
      render :list_moods, status: :unprocessable_entity
    end
  end

  def update_condition_energy
    @condition = Condition.find(params[:id])
    @condition.energy_level = params[:energy_level].to_i
    @condition.update(energy_level: params[:energy_level].to_i)
    redirect_to list_symptoms_path + "?id=#{@condition.id}"
  end

  def update_condition_symptom
    # sleep 3
    @selected_symptoms = []
    @condition = Condition.find(params[:id])
    @condition_id = @condition.id

    Symptom.all.each do |s|
      if params.include?(s.name)
        @selected_symptoms << s
      end
    end

    @selected_symptoms.each do |s|
      @symptoms_association = SymptomsByCondition.new
      @symptoms_association.condition_id = @condition_id
      @symptoms_association.symptom_id = s.id
      render :list_symptoms, status: :unprocessable_entity unless @symptoms_association.save
    end
    redirect_to recipes_path + "?id=#{@condition.id}"
  end

  def update_condition_recipe
    @condition = Condition.where(user: current_user).last
    @condition.recipe_id = params[:recipe]
    @condition.update(recipe_id: params[:recipe])
    redirect_to recap_path
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
  end
end
