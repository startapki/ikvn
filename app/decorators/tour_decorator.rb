class TourDecorator < Draper::Decorator
  delegate_all

  decorates_association :problems

  def name
    [source.name, name_hint].compact.join(' ').try(:html_safe)
  end

  def state
    if started_at.nil?
      'draft'
    elsif started_at <= Time.now && finished_at.nil? && reviewed_at.nil?
      'started'
    elsif finished_at <= Time.now && reviewed_at.nil?
      'finished'
    elsif reviewed_at <= Time.now
      'completed'
    elsif Time.now < started_at
      'scheduled'
    elsif Time.now < finished_at
      'started'
    elsif Time.now < reviewed_at
      'finished'
    end
  end

  private

  def name_hint
    h.capture do
      h.content_tag(:small) do
        h.concat '('

        case state
        when 'draft'
          h.concat h.t('tour.state.draft')
        when 'scheduled'
          h.concat h.t('tour.state.scheduled_in')
          h.concat ' '
          h.concat h.time_ago_in_words(started_at)
        when 'started'
          if finished_at
            h.concat h.t('tour.state.in_progress_for_next')
            h.concat ' '
            h.concat h.distance_of_time_in_words(Time.now, finished_at)
          else
            h.concat h.t('tour.state.in_progress')
          end
        when 'finished'
          if reviewed_at
            h.concat h.t('tour.state.on_review_for_next')
            h.concat ' '
            h.concat h.distance_of_time_in_words(Time.now, reviewed_at)
          else
            h.concat h.t('tour.state.on_review')
          end
        when 'completed'
          h.concat h.t('tour.state.completed_in')
          h.concat ' '
          h.concat h.time_ago_in_words(reviewed_at)
        end

        h.concat ')'
      end
    end
  end
end
