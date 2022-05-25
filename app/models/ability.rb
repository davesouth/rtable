class Ability
  include CanCan::Ability

  def initialize(user)
    send(user.try(:role) || 'guest')
  end

  def owner
    can :manage, Category
    can :manage, Card
    can :manage, Ticket
    can :manage, Memo
    can :manage, Note
    can :manage, User
  end

  # def staff
  #   can :read, Revision
  #   can :read, Report
  #   can :manage, Card
  #   can :manage, Contact
  #   can [:read, :create, :update], Project
  #   can :destroy, Project, has_memos?: false
  #   can [:read, :create], Memo
  #   can [:update, :destroy], Memo, locked?: false
  #   cannot :manage, Transition
  #   can :read, Doc
  #   can [:create, :update, :destroy], Doc, expired?: false
  # end

  # def regular
  #   can [:read, :create], Contact
  #   can [:update], Contact, expired?: false
  #   can :read, Card
  #   can [:read, :create, :update], Project
  #   can :destroy, Project, has_memos?: false
  #   can [:read, :create], Memo
  #   can [:update, :destroy], Memo, locked?: false
  #   cannot :manage, Transition
  #   can :read, Doc
  #   can [:create, :update, :destroy], Doc, expired?: false
  # end

  def guest
  end
end
