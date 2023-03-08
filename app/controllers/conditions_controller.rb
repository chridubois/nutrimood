class ConditionsController < ApplicationController

  def question1
    @moods = Mood.all
  end

  def question2
    @mood_id = params[:mood]
    @condition = Condition.create(mood_id: @mood_id, user: current_user)
  end

  def question4
    @symptoms = Symptom.all
# récupère l'instance de @condition crée en Q2
    # @condition = Condition.find(params[:id]) # ??? à voir fin Q2
# crée une instance de la table de jointure symptoms_by_condition
    # @symptoms_association = NomTableJ.new
# récup les @symptoms = id_symptoms du formulaire
    # @symptoms = []
# pour chaque ID_symptom récup:
#      jointure asso ID
# upload @condition
  end

  def question3
    @condition = Condition.find_by(user: current_user)
    @condition.energy_level = params[:energy_level]
    @condition.update(energy_level: params[:energy_level])
  end
end
