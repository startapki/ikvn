class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, League
    can :read, Tournament

    can :read, Problem

    can :read, Participation

    if user.persisted?
      can :create, Participation, user_id: user.id
    end

    if user.admin?
      can :update, League
      can :update, Tournament

      can :manage, Season
      cannot :destroy, Season, &:active?

      can :manage, Tour
      cannot :destroy, Tour, &:active?

      can :manage, Problem
      cannot :destroy, Problem, &:solutions?

      can :manage, Participation
      can :read, Solution
    else
      can :read, Season, Season.active, &:active?
      can :read, Tour, Tour.active, &:active?
    end

    if user.judge?
      can :read, Solution
      can :manage, Score
    elsif !user.admin?
      can :manage, Solution
    end
  end
end
