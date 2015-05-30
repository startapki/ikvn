class ProblemDecorator < Draper::Decorator
  delegate_all

  def name
    if persisted?
      h.t('problem.name', position: position)
    else
      h.t('problem.new')
    end
  end
end
