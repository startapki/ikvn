class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, League
    can :read, Tournament

    if user.admin?
      can :update, League
      can :update, Tournament

      can :manage, Season
      cannot :destroy, Season, &:active?

      can :manage, Tour
      cannot :destroy, Tour, &:active?
    else
      can :read, Season, Season.active, &:active?
      can :read, Tour, Tour.active, &:active?
    end
  end
end
