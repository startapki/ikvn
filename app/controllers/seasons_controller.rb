class SeasonsController < ApplicationController
  load_and_authorize_resource except: [:index, :new]

  decorates_assigned :season

  before_action :prepare_breadcrumbs, only: :edit

  helper_method :current_participation

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

  def current_participation
    @current_participation ||= current_user_participations.find_by(
      season: @season
    ) if @season.present?
  end

  def season_params
    params.require(:season).permit(:name, :description, :tournament_id)
  end

  def prepare_breadcrumbs
    add_breadcrumb @season.tournament.name, :root_path
    add_breadcrumb @season.decorate.name, @season
  end
end
