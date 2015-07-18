class ScoresController < ApplicationController
  load_and_authorize_resource

  def create
    @score.save!

    redirect_to @score.solution.problem.tour
  end

  def update
    @score.update(score_params)

    redirect_to @score.solution.problem.tour
  end

  private

  def score_params
    params.require(:score).permit(:solution_id, :value, :participation_id)
  end
end
