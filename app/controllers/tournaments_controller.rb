class TournamentsController < ApplicationController
  decorates_assigned :tournament, :seasons

  def show
    @tournament = Tournament.accessible_by(current_ability, :read)
                            .first

    @seasons = @tournament.seasons.includes(:tours)
                          .accessible_by(current_ability, :read)
                          .order(created_at: :desc)

    add_breadcrumb @tournament.name, :root_path
  end
end
