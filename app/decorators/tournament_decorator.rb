class TournamentDecorator < Draper::Decorator
  delegate_all

  def new_season
    h.content_tag(:div, class: 'season new draft panel panel-default') do
      h.content_tag(:div, class: 'panel-heading') do
        h.link_to(h.new_season_path(tournament_id: id)) do
          h.concat h.icon('plus')
          h.concat ' '
          h.concat h.t('season.new')
        end
      end
    end
  end
end
