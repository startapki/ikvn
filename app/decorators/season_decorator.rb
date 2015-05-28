class SeasonDecorator < Draper::Decorator
  delegate_all

  def state
    if active?
      'active'
    else
      'inactive'
    end
  end
end
