class ConditionsController < ApplicationController

  def question1
    @moods = Mood.all
  end

  def question2
    @mood_id = params[:mood]
    @condition = Condition.create(mood_id: @mood_id, user: current_user)
  end

  def question3
    @condition = Condition.find_by(user: current_user)
    @condition.energy_level = params[:energy_level]
    @condition.update(energy_level: params[:energy_level])
  end

  def question4
    @symptoms = Symptom.all
    @symptoms_association = SymptomsByCondition.new
    @condition_id = Condition.find_by(user: current_user).id
    @symptoms_association.condition_id = @condition_id
# ok pour un ou plsr symptomes => crée new table de jointure

    @symptoms_association.symptom_id = params[:my_symptoms]
    @symptoms_association.save
# redirect_to recipes_path(@condition)
  end

end
