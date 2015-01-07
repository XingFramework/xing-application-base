
require 'tasks/dependency_utils'

class YamlConfigValidator
  include DependencyUtils

  attr_accessor :yaml_hash, :results
  def initialize
    self.yaml_hash = YAML.load(File.open(file_under_test))
    self.results = []
  end

  # Validate only with common secrets requirements
  def validate(*envs)
    envs << 'test' if envs.include?('development')
    self.results.push(*envs.map{ |env|
      HashValidator.validate(yaml_hash, { env => rules(env) })
    })
  end

  def report!
    dep_fail("#{file_under_test} didn't contain required values.  Errors were: #{errors}")
  end

  def errors
    self.results.reduce({}) do |errs, validator|
      errs.deep_merge!(validator.errors)
    end
  end

  def assert_existence
    unless File.exists?(file_under_test)
      dep_fail("Please create #{file_under_test}, check the .example for format")
    end
  end
end
