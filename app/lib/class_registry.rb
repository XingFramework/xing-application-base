module ClassRegistry
  module ClassMethods
    def registry
      @registry ||= {}
    end

    def register(role_name, klass=self)
      raise "Invalid registration: #{role_name} exists" if registrar.registry.keys.include?(role_name)
      registrar.registry[role_name] = klass
    end

    def registry_key(klass)
      matches = registrar.registry.select{ |key, val| val == klass}.keys.first
    end

    def users
      User.where(:role_name => registrar.registry_key(self))
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
