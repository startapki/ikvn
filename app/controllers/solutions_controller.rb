class SolutionsController < ApplicationController
  load_and_authorize_resource except: [:index, :new]

  def new
  end

  def create
    if @solution.save!
      redirect_to @solution.problem.tour, notice: 'Saved'
    else
      redirect_to @solution.problem.tour, error: 'Not Saved'
    end
  end

  private

  def solution_params
    params.require(:solution).permit(:content, :problem_id, :participation_id)
  end
end
