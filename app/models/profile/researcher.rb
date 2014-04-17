class Profile::Researcher < ActiveRecord::Base
  Profile.register('Researcher', self)

  belongs_to :user
end

