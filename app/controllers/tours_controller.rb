class ToursController < ApplicationController
  load_and_authorize_resource except: [:index, :new]

  before_action :prepare_breadcrumbs, only: [:show, :edit]

  def show
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

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :season_id)
  end

  def prepare_breadcrumbs
    add_breadcrumb @tour.season.tournament.name, :root_path
    add_breadcrumb @tour.season.name, :root_path
    add_breadcrumb (@tour.name || t('tour.new')), @tour
  end
end
