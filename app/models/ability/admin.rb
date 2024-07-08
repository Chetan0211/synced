class Ability::Admin
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Administration, id: user.administration_id
    end
  end
end
  