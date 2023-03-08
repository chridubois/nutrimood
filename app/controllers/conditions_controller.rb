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


end
