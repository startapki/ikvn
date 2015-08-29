class ProblemsController < ApplicationController
  load_and_authorize_resource except: [:index, :new]

  decorates_assigned :problem

  before_action :prepare_breadcrumbs, only: :edit

  helper_method :current_participation

  def new
    @problem = Problem.new(tour_id: params[:tour_id])
    authorize! :new, @problem
    prepare_breadcrumbs
  end

  def edit
  end

  def create
    if @problem.save
      redirect_to @problem.tour, notice: t('model.created')
    else
      render :new
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to @problem.tour, notice: t('model.updated')
    else
      render :edit
    end
  end

  def destroy
    @problem.destroy

    redirect_to @problem.tour, notice: t('model.destroyed')
  end

  private

  def current_participation
    @current_participation ||= current_user_participations.find_by(
      season: @problem.try(:tour).try(:season)
    ) if @problem.present?
  end

  def problem_params
    params.require(:problem).permit(:tour_id, :content)
  end

  def prepare_breadcrumbs
    add_breadcrumb @problem.tour.season.tournament.name, :root_path
    add_breadcrumb @problem.tour.season.name, :root_path
    add_breadcrumb @problem.tour.name, @problem.tour
    add_breadcrumb @problem.decorate.name, @problem
  end
end
