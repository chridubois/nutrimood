class ConditionsController < ApplicationController

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
    @symptoms_association = SymptomsByCondition.new
    @condition_id = Condition.find_by(user: current_user).id
    @symptoms_association.condition_id = @condition_id

# ok pour un ou plsr symptomes => crée new table de jointure

    @symptoms_association.symptom_id = params[:my_symptoms]
    @symptoms_association.save
    redirect_to recipes_path

  end

#   def question1
#     @moods = Mood.all
#   end

#   def question2
#     @mood_id = params[:mood]
#     @condition = Condition.create(mood_id: @mood_id, user: current_user)
#   end

#   def question3
#     @condition = Condition.find_by(user: current_user)
#     @condition.energy_level = params[:energy_level]
#     @condition.update(energy_level: params[:energy_level])
#   end

#   def question4
#     @symptoms = Symptom.all
#     @symptoms_association = SymptomsByCondition.new

#     @condition_id = Condition.find_by(user: current_user).id
#     @symptoms_association.condition_id = @condition_id

#     @symptoms_association.symptom_id = params[:my_symptoms]
#     @symptoms_association.save
#     redirect_to recipes_path(@condition)
#   end


# def mood
#   @moods = Mood.all
# end

# def create_condition
#   @mood_id = params[:mood]
#   @condition = Condition.create(mood_id: @mood_id, user: current_user)
# end

# def update_condition_energy
#   @condition = Condition.find_by(user: current_user)
#   @condition.energy_level = params[:energy_level]
#   @condition.update(energy_level: params[:energy_level])
# end

# def update_condition_symptom
#   @symptoms = Symptom.all
#   @symptoms_association = SymptomsByCondition.new

#   @condition_id = Condition.find_by(user: current_user).id
#   @symptoms_association.condition_id = @condition_id

#   @symptoms_association.symptom_id = params[:my_symptoms]
#   @symptoms_association.save
#   raise
#   redirect_to recipes_path(@condition)
# end
end
