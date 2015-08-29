class SolutionsController < ApplicationController
  load_and_authorize_resource except: [:index, :new]

  decorates_assigned :solution

  def new
    @solution = Solution.new(problem_id: params[:problem_id],
                             participation_id: params[:participation_id])
  end

  def create
    if @solution.save
      redirect_to current_tour, notice: t('model.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @solution.update(solution_params)
      redirect_to current_tour, notice: t('model.updated')
    else
      render :edit
    end
  end

  def destroy
    @solution.destroy

    redirect_to current_tour, notice: t('model.destroyed')
  end

  private

  def solution_params
    params.require(:solution).permit(:content, :problem_id, :participation_id)
  end

  def current_tour
    @solution.problem.tour
  end
end
