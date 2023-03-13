class ConditionsController < ApplicationController
  before_action :set_cache_headers, only: %i[list_moods list_symptoms]

  def list_moods
    @moods = Mood.all
  end

  def list_energy
  end

  def list_symptoms
    @symptoms = Symptom.all
  end

  def create_condition
    @mood_id = params[:mood]
    @condition = Condition.create(mood_id: @mood_id, user: current_user)
    redirect_to list_energy_path
  end

  def update_condition_energy
    @condition = Condition.find_by(user: current_user)
    @condition.energy_level = params[:energy_level]
    @condition.update(energy_level: params[:energy_level])
    redirect_to list_symptoms_path
  end

  def update_condition_symptom
    @selected_symptoms = []
    @condition_id = Condition.find_by(user: current_user).id

    Symptom.all.each do |s|
      if params.include?(s.name)
        @selected_symptoms << s
      end
    end

    @selected_symptoms.each do |s|
      @symptoms_association = SymptomsByCondition.new
      @symptoms_association.condition_id = @condition_id
      @symptoms_association.symptom_id = s.id
      @symptoms_association.save
    end

    # redirect_to recipes_path
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
  end
end
