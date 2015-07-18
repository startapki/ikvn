class ToursController < ApplicationController
  load_and_authorize_resource except: [:new, :results]
  load_resource only: [:results]

  decorates_assigned :tour

  before_action :prepare_breadcrumbs, only: [:show, :edit, :results]

  helper_method :current_participation

  def show
    @participation = Participation.find_or_initialize_by(user: current_user,
                                                         season: @tour.season)
  end

  def new
    @tour = Tour.new(season_id: params[:season_id])
    authorize! :new, @tour
    prepare_breadcrumbs
  end

  def edit
  end

  def create
    if @tour.save!
      redirect_to @tour, notice: t('model.created')
    else
      render :new
    end
  end

  def update
    if @tour.update(tour_params)
      redirect_to @tour, notice: t('model.updated')
    else
      render :edit
    end
  end

  def destroy
    @tour.destroy

    redirect_to root_url, notice: t('model.destroyed')
  end

  def results
    authorize! :view_results, tour
    @users = User.joins(:participations)
                 .where(role: User.roles[:user])
                 .where(participations: { season: @tour.season })
  end

  private

  def current_participation
    @current_participation ||= current_user_participations.find_by(
      season: @tour.try(:season)
    ) if @tour.present?
  end

  def tour_params
    params
    .require(:tour)
    .permit(:name, :description, :season_id,
            :started_at, :finished_at, :reviewed_at)
  end

  def prepare_breadcrumbs
    add_breadcrumb @tour.season.tournament.name, :root_path
    add_breadcrumb @tour.season.name, :root_path
    add_breadcrumb @tour.name || t('tour.new'), @tour
  end
end
