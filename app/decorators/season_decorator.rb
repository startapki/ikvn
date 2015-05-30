class SeasonDecorator < Draper::Decorator
  delegate_all

  def state
    if active?
      'active'
    else
      'inactive'
    end
  end

  def new_tour
    h.content_tag(:div, class: 'tour new draft') do
      h.link_to(h.new_tour_path(season_id: id)) do
        h.concat h.icon('plus')
        h.concat ' '
        h.concat h.t('tour.new')
      end
    end
  end

  def name
    source.name || h.t('season.new')
  end
end
