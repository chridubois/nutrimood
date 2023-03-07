class ConditionsController < ApplicationController

  def question1
    @condition = Condition.new
    @moods = Mood.all

  end

  def question2
    @mood_id = params[:mood]
    @condition = Condition.create(mood_id: @mood_id, user: current_user)
    redirect_to question3_path
  end

  def question3

  end

end
