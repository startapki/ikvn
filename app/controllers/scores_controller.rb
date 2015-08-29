class ScoresController < ApplicationController
  load_and_authorize_resource

  def create
    @score.save!

    redirect_to @score.solution.problem.tour
  end

  def update
    @score.update(score_params)

    respond_to do |format|
      format.html { redirect_to @score.solution.problem.tour }
      format.js
    end
  end

  private

  def score_params
    params.require(:score).permit(:solution_id, :value, :participation_id)
  end
end
