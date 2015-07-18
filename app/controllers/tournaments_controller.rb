class TournamentsController < ApplicationController
  load_and_authorize_resource only: [:show, :edit, :update]

  decorates_assigned :tournament, :seasons

  before_action :prepare_breadcrumbs, only: :edit

  def show
    @tournament = Tournament.accessible_by(current_ability, :read)
                            .first

    @seasons = @tournament.seasons
                          .accessible_by(current_ability, :read)
                          .order(created_at: :desc)

    prepare_breadcrumbs
  end

  def edit
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to root_path, notice: t('model.updated')
    else
      render :edit
    end
  end

  private

  def tournament_params
    params
    .require(:tournament)
    .permit(:name, :description)
    .merge(league: League.first)
  end

  def prepare_breadcrumbs
    add_breadcrumb @tournament.name, :root_path
  end
end
