class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, League
    can :read, Tournament
    can :read, Problem
    can :read, Participation

    can :create, Participation, user_id: user.id if user.persisted?

    if user.admin?
      can :update, League
      can :update, Tournament

      can :manage, Season
      cannot :destroy, Season, &:active?

      can :manage, Tour
      can :view_results, Tour
      cannot :destroy, Tour, &:active?

      can :manage, Problem
      cannot :destroy, Problem, &:solutions?

      can :manage, Participation
      can :read, Solution
    else
      can :read, Season, Season.active, &:active?
      can :read, Tour, Tour.active, &:active?
      can :view_results, Tour do |tour|
        tour.reviewed?
      end
    end

    if user.judge?
      can :read, Solution
      can :manage, Score
      can :judge, Tour do |tour|
        tour.finished? && !tour.reviewed?
      end
    elsif !user.admin? && user.persisted?
      can :manage, Solution do |solution|
        solution.problem.tour.solutionable?
      end
    end
  end
end
