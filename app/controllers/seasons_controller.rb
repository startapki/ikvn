class SeasonsController < ApplicationController
  load_and_authorize_resource except: [:index, :new]

  before_action :prepare_breadcrumbs, only: [:show, :edit]

  def show
  end

  def new
    @season = Season.new(tournament_id: params[:tournament_id])
    authorize! :new, @season
    prepare_breadcrumbs
  end

  def edit
  end

  def create
    if @season.save!
      redirect_to root_path, notice: t('model.created')
    else
      render :new
    end
  end

  def update
    if @season.update(season_params)
      redirect_to root_path, notice: t('model.updated')
    else
      render :edit
    end
  end

  def destroy
    @season.destroy

    redirect_to root_url, notice: t('model.destroyed')
  end

  private

  def season_params
    params.require(:season).permit(:name, :description, :tournament_id)
  end

  def prepare_breadcrumbs
    add_breadcrumb @season.tournament.name, :root_path
    add_breadcrumb (@season.name || t('season.new')), @season
  end
end