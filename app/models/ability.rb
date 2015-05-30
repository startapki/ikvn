class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, League
    can :read, Tournament

    can :read, Problem

    can :read, Participation

    if user.persisted?
      can :create, Participation, user_id: user.id, role: 'player'
    end

    if user.admin?
      can :update, League
      can :update, Tournament

      can :manage, Season
      cannot :destroy, Season, &:active?

      can :manage, Tour
      cannot :destroy, Tour, &:active?

      can :manage, Problem
      cannot :destroy, Problem, &:has_solutions?

      can :manage, Participation
    else
      can :read, Season, Season.active, &:active?
      can :read, Tour, Tour.active, &:active?
    end
  end
end
