class Role::Admin < Role
  Role.register 'Admin', self

  def set_abilities(ability)
    ability.can :manage, Page
    ability.can :manage, MenuItem
    ability.can :manage, Document
    ability.can :manage, Image
  end

end
