class ConditionsController < ApplicationController

  def question1
<<<<<<< HEAD
    @moods = Mood.all
=======
    @condition = Condition.new
    @moods = Mood.all

>>>>>>> 318e5fe227525a517d403359883da2e29a87d59c
  end

  def question2
    @mood_id = params[:mood]
    @condition = Condition.create(mood_id: @mood_id, user: current_user)
    redirect_to question3_path
  end

  def question3

  end

end
