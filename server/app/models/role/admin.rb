class Role::Admin < Role
  Role.register 'Admin', self
end
