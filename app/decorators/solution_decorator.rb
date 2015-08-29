class SolutionDecorator < Draper::Decorator
  delegate_all

  decorates_association :problem
end
